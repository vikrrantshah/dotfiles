#!/bin/bash

open -a Docker

SESSION="arbio-nexus"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

CD_FRONTEND='cd nexus'
CD_BACKEND='cd backend'

if [ "$SESSIONEXISTS" = "" ]; then
  tmux new-session -d -s $SESSION

  # Frontend Editor Window
  tmux rename-window -t 0 'Nexus'
  tmux send-keys -t 'Nexus' "$CD_FRONTEND" C-m 'nvim' C-m

  # Backend Editor Window
  tmux new-window -t $SESSION:1 -n 'Backend'
  tmux send-keys -t 'Backend' "$CD_BACKEND" C-m 'nvim' C-m

  # Frontend Server Window
  tmux new-window -t $SESSION:2 -n 'Neuxs Server'
  tmux send-keys -t 'Neuxs Server' "$CD_FRONTEND" C-m 'npm run dev' C-m

  # Backend Server Window
  tmux new-window -t $SESSION:3 -n 'Backend Server'
  tmux send-keys -t 'Backend Server' "$CD_BACKEND" C-m 'docker compose up -d' C-m 'docker compose stop app' C-m 'npm run start:dev' C-m

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
