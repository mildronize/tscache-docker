#!/usr/bin/env bash

server=$ZOOKEEPER_HOST
port=$ZOOKEEPER_PORT
command="/opt/bin/start_opentsdb.sh"

# Define functions
function check_prerequisite {
    # http://stackoverflow.com/a/677212
    hash $1 2>/dev/null || { echo >&2 "$1 isn't installed.  Aborting."; exit 1; }
}

check_prerequisite telnet

TELNETCOUNT=`sleep 5 | telnet $server $port | grep -v "Connection refused" | grep "Connected to" | grep -v grep | wc -l`

if [ $TELNETCOUNT -eq 1 ] ; then
    # Telnet up!
    ${command}
    echo "Can connect via Telnet at ${server}:${port}"
else
    echo "Cannot connect to Zookeeper at ${server}:${port}"
    exit 1
fi
