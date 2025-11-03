#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
set -e

# clear ready flag
rm -f /tmp/ready

vllm serve $MODEL \
  --host 0.0.0.0 \
  --port 8000 \
  --max-model-len 36000 \
  --gpu-memory-utilization 0.90 \
  --dtype float16 \
  --max-num-batched-tokens 1024 \
  --tensor-parallel-size 1 &

# start ollama, wait for it to serve
echo "Starting VLLM..."
until curl -s http://localhost:8000 > /dev/null; do
  sleep 1
done

# set container as ready
touch /tmp/ready

# start
bash start.sh
