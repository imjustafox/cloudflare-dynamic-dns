#!/bin/sh
set -eu

interval="${UPDATE_INTERVAL:-60}"

trap 'exit 0' TERM INT

while :; do
    python3 /app/core.py || echo "core.py exited $?"
    sleep "$interval" &
    wait $! || exit 0
done
