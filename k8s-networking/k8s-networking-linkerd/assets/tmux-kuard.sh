tmux -2 new-session -d -s $KUARD

tmux select-window -t $KUARD:1
tmux select-pane -t 1 
tmux send-keys "kubectl port-forward deploy/kuard 8080:8080 --address 0.0.0.0" C-m
tmux select-pane -t 0

# Set default window
