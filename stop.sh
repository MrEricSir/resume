#!/bin/bash
cd "$(dirname "$0")"

if [ -f .jekyll-pid ]; then
  PID=$(cat .jekyll-pid)
  if kill "$PID" 2>/dev/null; then
    echo "Stopped Jekyll server (PID $PID)"
  else
    echo "Process $PID not running, cleaning up PID file."
  fi
  rm -f .jekyll-pid
else
  # Fallback: try to find and kill any jekyll serve process
  PID=$(pgrep -f "jekyll serve" | head -1)
  if [ -n "$PID" ]; then
    kill "$PID"
    echo "Stopped Jekyll server (PID $PID)"
  else
    echo "No Jekyll server found."
  fi
fi
