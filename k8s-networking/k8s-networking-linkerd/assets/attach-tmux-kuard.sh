sleep 2
clear
tmux new-window -t $KUARD:1 -n 'Kuard'
tmux select-window -t $KUARD:1
tmux split-window -v
tmux select-pane -t 1 
tmux send-keys "kubectl port-forward deploy/kuard 8080:8080 --address 0.0.0.0" C-m
tmux select-pane -t 0
tmux -2 attach-session -t $KUARD
