#!/bin/bash

# Create tmux session
tmux new-session -d
tmux rename 'dev'
tmux new-window -n 'deployments' -c /root/ -d
tmux split-window -h -t 2. -c /root/ -d
tmux attach -t dev
