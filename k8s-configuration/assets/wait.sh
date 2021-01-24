#!/bin/bash

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
  echo -n "Starting cluster"
  waitForCompletion /opt/.clusterstarted
  echo -n "Installing Octant"
  waitForCompletion /opt/.octantinstalled
  echo -n "Waiting for nodes ready"
  waitForCompletion /opt/.nodesready
  # echo -n "Completing"
  # waitForCompletion /opt/.backgroundfinished
  echo -n "Cloning examples"
  waitForCompletion /opt/.examplescloned
  echo "All Set"
  echo ""
}

showProgress