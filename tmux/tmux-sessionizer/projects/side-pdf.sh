SESSION="side-pdf"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]; then
  tmux new-session -d -s $SESSION

  # Editor Window
  tmux rename-window -t 0 'Editor'
  tmux send-keys -t 'Editor' 'nvim' C-m

  # Server Window
  tmux new-window -t $SESSION:1 -n 'Server'
  tmux send-keys -t 'Server' 'wails dev' C-m
fi

tmux attach-session -t $SESSION:0
