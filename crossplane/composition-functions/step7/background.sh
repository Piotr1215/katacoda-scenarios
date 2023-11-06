#!/usr/bin/env bash

set -eo pipefail

# Add source and line number wher running in debug mode: __run_with_xtrace.sh background.sh
# Set new line and tab for word splitting
IFS=$'\n\t'

git checkout 2-example-files
