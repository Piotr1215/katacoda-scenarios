sleep 2
clear
tmux select-window -t $SESSION:1
tmux select-pane -t 1 
tmux send-keys "kubectl port-forward deploy/kuard 8080:8080 --address 0.0.0.0" C-m
tmux select-pane -t 0
tmux select-window -t $SESSION:1
tmux -2 attach-session -t $SESSION
