#!/bin/bash

# Start a new tmux session in detached mode
tmux new-session -d -s develop

# Split the window horizontally
tmux split-window -v

# Attach to the tmux session
tmux attach -t develop
