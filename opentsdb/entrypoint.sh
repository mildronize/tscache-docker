#!/usr/bin/env bash

server=$ZOOKEEPER_HOST
delay=2
command="/opt/bin/start_opentsdb.sh"

# Define functions
function check_prerequisite {
    # http://stackoverflow.com/a/677212
    hash $1 2>/dev/null || { echo >&2 "$1 isn't installed.  Aborting."; exit 1; }
}

function split {
    # string   $1 
    # splitter $2
    echo $1 | tr "$2" "\n"
}

check_prerequisite telnet
zookeeper_server=`split $ZOOKEEPER_HOST :`
zookeeper_host=${zookeeper_server[0]}
zookeeper_port=${zookeeper_server[1]}

# Start main script
for i in /opt/opentsdb/opentsdb.conf; \
    do \
        sed -i "s#{{ZOOKEEPER_HOST}}#$ZOOKEEPER_HOST#g;" $i; \
    done

# Waiting for zookeeper ready!
while true; do
    TELNETCOUNT=`telnet ${zookeeper_host} ${zookeeper_port} | grep -v "Connection refused" | grep "Connected to" | grep -v grep | wc -l`

    if [ $TELNETCOUNT -eq 1 ] ; then
        # Telnet up!
        echo "Can connect via Telnet at ${zookeeper_host}:${zookeeper_port}"
        break
    else
        echo "Cannot connect to Zookeeper at ${zookeeper_host}:${zookeeper_port}"
    fi
    echo "Sleep ${delay}"
    sleep ${delay}
done

sleep 20
${command}
