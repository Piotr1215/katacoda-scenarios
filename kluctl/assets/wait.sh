#!/bin/bash

waitForCompletion() {
	local -r delay='0.75'
	local spinstr='\|/-'
	local temp
	while true; do
		sudo grep -i "done" $1 &>/dev/null
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

showProgress() {
	echo -n "Checking node status"
	waitForCompletion /opt/.clusterstarted
	echo -n "Installing additional tools & configuring system"
	waitForCompletion /opt/.toolsinstalled
	echo -n "Installing octant"
	waitForCompletion /opt/.octantinstalled
	waitForCompletion /opt/.backgroundfinished
	# Pick up any changes during background

	echo "All Set"
	echo ""
}

showProgress
