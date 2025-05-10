SESSION="dotfiles"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]; then
  tmux new-session -d -s $SESSION

  tmux rename-window -t 0 'Editor'
  tmux send-keys -t 'Editor' 'nvim' C-m
fi

tmux attach-session -t $SESSION:0
