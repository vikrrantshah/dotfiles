#!/bin/bash

SESSION="personal-website"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]; then
  tmux new-session -d -s $SESSION

  # Editor Window
  tmux rename-window -t 0 'Editor'
  tmux send-keys -t 'Editor' 'nvim' C-m

  # Templ Window
  tmux new-window -t $SESSION:2 -n 'Templ'

  # Server Window
  tmux new-window -t $SESSION:1 -n 'Web Server'

  tmux send-keys -t 'Templ' 'make templ' C-m
  tmux send-keys -t 'Web Server' 'air' C-m
fi

tmux attach-session -t $SESSION:0
