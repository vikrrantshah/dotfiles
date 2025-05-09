#!/bin/bash

open -a Docker
open -a 'Firefox'

SESSION="sedomo"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

CD_FRONTEND='cd housemeister-app'
CD_BACKEND='cd housemeister-backend'

if [ "$SESSIONEXISTS" = "" ]; then
  tmux new-session -d -s $SESSION

  # Frontend Editor Window
  tmux rename-window -t 0 'Frontend'
  tmux send-keys -t 'Frontend' "$CD_FRONTEND" C-m 'nvim' C-m

  # Backend Editor Window
  tmux new-window -t $SESSION:1 -n 'Backend'
  tmux send-keys -t 'Backend' "$CD_BACKEND" C-m 'nvim' C-m

  # Frontend Server Window
  tmux new-window -t $SESSION:2 -n 'Frontend-NIX'
  tmux send-keys -t 'Frontend-NIX' "$CD_FRONTEND" C-m 'nix develop' C-m 'yarn dev' C-m

  # Backend Server Window
  tmux new-window -t $SESSION:3 -n 'Backend-NIX'
  tmux send-keys -t 'Backend-NIX' "$CD_BACKEND" C-m 'nix develop' C-m 'docker compose up -d' C-m 'symfony serve' C-m

  # Shell Panes for both Frontend and Backend
  tmux new-window -t $SESSION:4 -n 'Shells'
  tmux select-window -t $SESSION:4
  tmux split-window -h -t $SESSION:4

  tmux select-pane -t $SESSION:4.0 -T 'Frontend-Shell'
  tmux select-pane -t $SESSION:4.1 -T 'Backend-Shell'

  tmux send-keys -t $SESSION:4.0 "$CD_FRONTEND" C-m "clear" C-m
  tmux send-keys -t $SESSION:4.1 "$CD_BACKEND" C-m "clear" C-m
fi

tmux attach-session -t $SESSION:0
