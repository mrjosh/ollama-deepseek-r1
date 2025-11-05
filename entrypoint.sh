#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
set -e

# clear ready flag
rm -f /tmp/ready

vllm serve $VLLM_MODEL \
  --host $VLLM_HOST \
  --port $VLLM_PORT \
  --max-model-len $VLLM_MAX_MODEL_LEN \
  --gpu-memory-utilization $VLLM_GPU_MEMORY_UTILIZATION \
  --dtype $VLLM_D_TYPE \
  --max-num-batched-tokens $VLLM_MAX_NUM_BATCHED_TOKENS \
  --tensor-parallel-size $VLLM_TENSOR_PARALLEL_SIZE \
  --enable-prefix-caching \
  --kv-cache-dtype auto &

# start ollama, wait for it to serve
echo "Starting VLLM..."
until curl -s http://localhost:8000 > /dev/null; do
  sleep 1
done

# set container as ready
touch /tmp/ready

# start
bash start.sh
