#!/bin/bash

list="$(tmux list-sessions)"

IFS=$'\n' read -rd '' SESSIONS <<<"$list"

SESSION_NAMES=()

j=0
while IFS= read -r session; do
  printf '%s: %s\n' "$j" "$session"
  SESSION_NAMES+=("$session")
  ((j += 1))
done <<<"$SESSIONS"

read -rp "Select session: " SESSION

echo "${SESSION_NAMES[$SESSION]}"

IFS=':' read -ra TARGET <<<"$IN"
