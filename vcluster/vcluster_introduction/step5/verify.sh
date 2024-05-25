#!/bin/bash

if vluster list | grep -q "new-vcluster"; then
	exit 0
else
	exit 1
fi
