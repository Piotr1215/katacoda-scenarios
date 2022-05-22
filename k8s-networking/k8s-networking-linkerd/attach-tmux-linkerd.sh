sleep 2
tmux kill-session -t $SESSION
clear
tmux -2 attach-session -t $SESSION
