#!/bin/bash

# Check if quiz-k8s vCluster exists in quiz-ns namespace
vcluster list 2>/dev/null | grep -E "quiz-k8s.*quiz-ns.*Running" >/dev/null 2>&1