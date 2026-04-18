#!/bin/bash
cd "$(dirname "$0")"

if [ -f .jekyll-pid ]; then
  echo "Server may already be running (PID file exists). Run ./stop.sh first."
  exit 1
fi

bundle exec jekyll serve --detach 2>&1 | tee /dev/stderr &
sleep 2

# Grab the PID of the Jekyll server
PID=$(pgrep -f "jekyll serve" | head -1)
if [ -n "$PID" ]; then
  echo "$PID" > .jekyll-pid
  echo "Jekyll server started (PID $PID)"
  open "http://127.0.0.1:4000"
else
  echo "Failed to start Jekyll server."
  exit 1
fi
