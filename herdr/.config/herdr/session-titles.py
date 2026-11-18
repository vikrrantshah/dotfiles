#!/usr/bin/env python3
"""Report each agent pane's own session title to Herdr as the `$session` sidebar token.

Herdr already tracks every agent pane's session reference (`agent_session`). This
loop resolves that reference to the title the agent itself stores, and reports
it with `herdr pane report-metadata`. It also reports a static `$icon` token.

  omp     first line of the session .jsonl is a {"type":"title"} header
  claude  last {"type":"custom-title"} (/rename) in the transcript, else last "ai-title"
  codex   last thread_name for the session id in ~/.codex/session_index.jsonl
"""

import glob
import json
import os
import shutil
import subprocess
import time

POLL_SECONDS = 2
SOURCE = "user:session-titles"
ICONS = {"claude": "✻", "codex": "◇", "omp": "π"}
HERDR = shutil.which("herdr") or "/opt/homebrew/bin/herdr"
CODEX_INDEX = os.path.expanduser("~/.codex/session_index.jsonl")
CLAUDE_PROJECTS = os.path.expanduser("~/.claude/projects")


class ClaudeTranscript:
    """Incrementally scans an append-only transcript; only new bytes are read."""

    def __init__(self, path):
        self.path = path
        self.offset = 0
        self.ai_title = None
        self.custom_title = None

    def title(self):
        try:
            with open(self.path, "rb") as handle:
                handle.seek(self.offset)
                chunk = handle.read()
        except OSError:
            return None
        end = chunk.rfind(b"\n") + 1  # leave a partial trailing line for the next poll
        for line in chunk[:end].splitlines():
            if b'"custom-title"' not in line and b'"ai-title"' not in line:
                continue
            try:
                record = json.loads(line)
            except ValueError:
                continue
            if record.get("type") == "custom-title" and record.get("customTitle"):
                self.custom_title = record["customTitle"]
            elif record.get("type") == "ai-title" and record.get("aiTitle"):
                self.ai_title = record["aiTitle"]
        self.offset += end
        return self.custom_title or self.ai_title


def omp_title(path):
    try:
        with open(path, "rb") as handle:
            record = json.loads(handle.readline())
    except (OSError, ValueError):
        return None
    return record.get("title") if record.get("type") == "title" else None


codex_cache = {"mtime": None, "names": {}}


def codex_title(session_id):
    try:
        mtime = os.stat(CODEX_INDEX).st_mtime_ns
    except OSError:
        return None
    if mtime != codex_cache["mtime"]:
        names = {}
        with open(CODEX_INDEX, encoding="utf-8") as handle:
            for line in handle:
                try:
                    record = json.loads(line)
                except ValueError:
                    continue
                if record.get("id") and record.get("thread_name"):
                    names[record["id"]] = record["thread_name"]
        codex_cache.update(mtime=mtime, names=names)
    return codex_cache["names"].get(session_id)


claude_transcripts = {}


def claude_title(ref):
    path = ref["value"] if ref.get("kind") == "path" else None
    if path is None:
        matches = glob.glob(os.path.join(CLAUDE_PROJECTS, "*", f"{ref['value']}.jsonl"))
        path = matches[0] if matches else None
    if path is None:
        return None
    transcript = claude_transcripts.setdefault(path, ClaudeTranscript(path))
    return transcript.title()


def resolve_title(ref):
    agent = ref.get("agent")
    if agent == "omp" and ref.get("kind") == "path":
        return omp_title(ref["value"])
    if agent == "claude":
        return claude_title(ref)
    if agent == "codex":
        return codex_title(ref["value"])
    return None


def herdr(*args):
    return subprocess.run([HERDR, *args], capture_output=True, text=True, timeout=5)


reported = {}  # pane_id -> (session, icon)


def poll():
    result = herdr("pane", "list")
    if result.returncode != 0:
        reported.clear()  # server down or restarting: re-report everything once it is back
        return
    panes = json.loads(result.stdout)["result"]["panes"]
    live = set()
    for pane in panes:
        pane_id = pane["pane_id"]
        ref = pane.get("agent_session")
        if not pane.get("agent") or not ref:
            if pane_id in reported:
                herdr("pane", "report-metadata", pane_id, "--source", SOURCE,
                      "--clear-token", "session", "--clear-token", "icon")
                del reported[pane_id]
            continue
        live.add(pane_id)
        wanted = (resolve_title(ref) or "", ICONS.get(ref.get("agent"), ""))
        if reported.get(pane_id) == wanted:
            continue
        # An empty token value clears that token in Herdr.
        herdr("pane", "report-metadata", pane_id, "--source", SOURCE,
              "--token", f"session={wanted[0]}", "--token", f"icon={wanted[1]}")
        reported[pane_id] = wanted
    for pane_id in set(reported) - live:
        del reported[pane_id]


if __name__ == "__main__":
    while True:
        try:
            poll()
        except Exception as error:  # keep the loop alive; launchd logs stderr
            print(f"session-titles: {error!r}", flush=True)
        time.sleep(POLL_SECONDS)
