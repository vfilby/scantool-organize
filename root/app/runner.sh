#!/bin/bash

# Default to running every 60s
INTERVAL="${ORGANIZE_INTERVAL:-60}"
if [ "$SIMULATE" = "false" ]; then
  CMD="run"
else
  CMD="sim"
fi

echo "Starting... will organize every $INTERVAL seconds."

while true; do
  organize $CMD /app/organize-rules.yaml
  sleep $INTERVAL
done
