#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
set -e

# clear ready flag
rm -f /tmp/ready

ollama serve &

# start ollama, wait for it to serve
echo "Starting Ollama..."
until curl -s http://localhost:11434 > /dev/null; do
  sleep 1
done

# pull and install models, or skip if they're present
for MODEL in $MODELS; do
  if ! ollama list | grep -q "$MODEL"; then
    echo "⚡️ Pulling model: $MODEL"
    ollama pull "$MODEL"
  else
    echo "⛳️ Model '$MODEL' already present."
  fi
done

# set container as ready
touch /tmp/ready

# start nginx
service start nginx;
npm start;
