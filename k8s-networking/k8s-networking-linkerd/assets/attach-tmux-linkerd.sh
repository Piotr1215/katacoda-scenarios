sleep 2
tmux kill-session -t $SESSION
sleep 1
tmux -2 attach-session -t $SESSION
clear
