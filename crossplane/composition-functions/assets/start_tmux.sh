#!/bin/bash

# Start a new tmux session in detached mode
tmux new-session -d -s develop

# Split the window horizontally
tmux split-window -h

# Set the pane titles
tmux select-pane -t 0
tmux send-keys "printf '\033]2;debug\033\\'" C-m

tmux select-pane -t 1
tmux send-keys "printf '\033]2;dev\033\\'" C-m

# Attach to the tmux session
tmux attach -t develop
