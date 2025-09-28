#!/bin/bash

# Default start directory
default_dir="/root/" # Update to your preferred default directory

# Desired start directory
start_dir="/root/"

# Check if the desired start directory exists, if not, use the default
if [ ! -d "$start_dir" ]; then
	start_dir="$default_dir"
fi

# Start a new tmux session in detached mode, using the determined start directory
tmux new-session -d -s develop -c "$start_dir"

# Split the window horizontally, using the same start directory
tmux split-window -v -c "$start_dir"

# Attach to the tmux session
tmux attach -t develop
