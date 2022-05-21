#!/bin/bash

sleep 5

waitForCompletion() {
  local -r delay='0.75'
  local spinstr='\|/-'
  local temp
  while true; do
    sudo grep -i "done" $1 &> /dev/null
    if [[ "$?" -ne 0 ]]; then
      temp="${spinstr#?}"
      printf " [%c]  " "${spinstr}"
      spinstr=${temp}${spinstr%"${temp}"}
      sleep "${delay}"
      printf "\b\b\b\b\b\b"
    else
      break
    fi
  done
  printf "    \b\b\b\b"
  echo ""
}

showProgress()
{
  echo -n "Waiting for cluster ready"
  waitForCompletion /opt/.nodesready
  echo -n "Installing Octant"
  waitForCompletion /opt/.octantinstalled
  echo -n "Cloning examples"
  waitForCompletion /opt/.examplescloned
  echo "Octant started in the background"
  waitForCompletion /opt/.backgroundfinished
  echo "All Set"
  echo ""
}

showProgress
