#!/usr/bin/env bash

set -eo pipefail
# set -x # For debugging

# Config python-watchdog"
watchdog_pattern="*.java"  # e.g. "*.py;*.txt"

# Waiting for hbase, preparing OpenTSDB script
# Here is `entrypoint.sh` of OpenTSDB dockerfile
echo "Preparing OpenTSDB config, waiting for HBase ready..."
/preparing_opentsdb.sh

echo "Running opentsdb developing environment..."
echo "[DEBUG MODE] Watching for file changing..."

# Wacth files
echo "Starting to watch $watchdog_pattern"
watchmedo shell-command \
    --patterns="$watchdog_pattern" \
    --recursive \
    --command='echo "`date +%T` ${watch_src_path}"' \
    $TSDB_DEV_PATH

sleep infinity
