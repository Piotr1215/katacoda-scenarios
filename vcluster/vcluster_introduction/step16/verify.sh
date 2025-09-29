#!/bin/bash

# Check if quiz-prepop vCluster exists in quiz-final namespace
vcluster list 2>/dev/null | grep -E "quiz-prepop.*quiz-final.*Running" >/dev/null 2>&1