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
  echo -n "Starting k3s Cluster"
  waitForCompletion /opt/.clusterstarted
  echo -n "Installing Helm"
  waitForCompletion /opt/.helminstalled
  echo -n "Installing Crossplane"
  waitForCompletion /opt/.crossplaneinstalled
  echo -n "Installing Crossplane CLI"
  waitForCompletion /opt/.crossplanecliinstalled
  echo -n "Installing Kuberentes Provider"
  waitForCompletion /opt/.kubernetesproviderinstalled
  echo -n "Installing Datree"
  waitForCompletion /opt/.datreeinstalled
  echo -n "Installing Octant"
  waitForCompletion /opt/.octantinstalled
  echo -n "Installing K9s"
  waitForCompletion /opt/.k9sinstalled
  waitForCompletion /opt/.backgroundfinished

  echo "All Set"
  echo ""
}

showProgress
