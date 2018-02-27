#!/usr/bin/env bash

# Support only one zookeeper host

set -eo pipefail
#set -x # For debugging

# Load Environment variables
env_opentsdb_home="$TSDB_HOME"
env_zookeeper_host="$HBASE_ZOOKEEPER_QUORUM"

# Input command to be run from arg
command="$1"

# Setup timezone
ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime  && echo ${TIMEZONE} > /etc/timezone

# Define functions
check_prerequisite() {
    # http://stackoverflow.com/a/677212
    local command=${1?ERROR: A command is reqiured}
    hash $command 2>/dev/null || { echo >&2 "$command isn't installed.  Aborting."; exit 1; }
}

split() {
    local string=${1?ERROR: A string is reqiured}
    local splitter=${2?ERROR: A splitter is reqiured}
    echo $string | tr "$splitter" "\n"
}

wait_for() {
    local host=${1?ERROR: A host is reqiured}
    local port=${2?ERROR: A port is reqiured}
    local delay=${3:-2} # Default is 2 seconds
    while true; do
        local telnet_count=`echo "exit" | telnet $host $port | grep -v "Connection refused" | grep "Connected to" | grep -v grep | wc -l`
        if [ $telnet_count -eq 1 ] ; then
            break
        else
            echo "Cannot connect to Zookeeper at ${host}:${port}"
        fi
        sleep $delay
    done
}

wait_for_hbase_master(){
    while true; do
        local num_hbase_master_error=`echo "status" | hbase shell | grep ERROR | wc -l`
        if [ $num_hbase_master_error -eq 0 ] ; then
            break
        else
            echo "HBase Master is not ready."
            echo "Try to check HBase status again"
        fi
    done
}

check_prerequisite telnet
zookeeper_server=`split $env_zookeeper_host :`
zookeeper_host=${zookeeper_server[0]}
zookeeper_port=${zookeeper_server[1]}

# Start main script
# --------------------------------

# Replacing configuration with enviroment variables
sed -i "s#{{HBASE_ZOOKEEPER_QUORUM}}#$env_zookeeper_host#g;" $env_opentsdb_home/opentsdb.conf

# Waiting for zookeeper ready!
wait_for $zookeeper_host $zookeeper_port

# Waiting for HBase Master ready
wait_for_hbase_master

# HBase Master is ready, run OpenTSDB
${command}
