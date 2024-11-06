#!/bin/bash

# Default to running every 60s
INTERVAL="${ORGANIZE_INTERVAL:-60}"

source /app/bin/activate

echo "Starting... will organize every $INTERVAL seconds."
echo `which python`
echo `which organize`


while true; do
  organize run /app/organize-rules.yaml
  sleep $INTERVAL
done
