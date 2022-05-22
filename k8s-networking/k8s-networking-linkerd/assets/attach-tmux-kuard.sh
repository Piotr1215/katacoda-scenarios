sleep 2
clear
tmux select-window -t $SESSION:1
tmux select-pane -t 0
tmux send-keys "kubectl port-forward deploy/kuard 8080:8080 --address 0.0.0.0" C-m
tmux -2 attach-session -t $SESSION
