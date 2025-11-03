#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
set -e

# clear ready flag
rm -f /tmp/ready

vllm serve &

# start ollama, wait for it to serve
echo "Starting VLLM..."
until curl -s http://localhost:8000 > /dev/null; do
  sleep 1
done

# set container as ready
touch /tmp/ready

# start
bash start.sh
