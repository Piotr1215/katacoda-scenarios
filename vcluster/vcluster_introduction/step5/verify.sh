#!/bin/bash

vcluster list | awk '/new-vcluster/ && /new-namespace/ { found=1 } END { exit !found }'
