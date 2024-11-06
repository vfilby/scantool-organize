#!/bin/bash

# Default to running every 60s
INTERVAL="${ORGANIZE_INTERVAL:-60}"

echo "Starting... will organize every $INTERVAL seconds."

while true; do
  organize run /app/organize-rules.yaml
  sleep $INTERVAL
done
