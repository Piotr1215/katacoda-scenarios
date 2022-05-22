export SESSION=$USER

tmux -2 new-session -d -s $SESSION

# Setup a window for tailing log files
tmux new-window -t $SESSION:1 -n 'Pods'
tmux split-window -v
tmux select-pane -t 1 
tmux send-keys "kubectl port-forward deploy/kuard 8080:8080 --address 0.0.0.0" C-m
tmux select-pane -t 0

# Set default window
tmux select-window -t $SESSION:1
