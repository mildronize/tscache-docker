#!/usr/bin/env bash

server=$ZOOKEEPER_HOST
delay=2
command="/opt/bin/start_opentsdb.sh"

# Define functions
function check_prerequisite {
    # http://stackoverflow.com/a/677212
    hash $1 2>/dev/null || { echo >&2 "$1 isn't installed.  Aborting."; exit 1; }
}

check_prerequisite telnet

# Start main script
for i in /opt/opentsdb/opentsdb.conf; \
    do \
        sed -i "s#::ZOOKEEPER_HOST::#$server#g;" $i; \
    done

sleep 5

while true; do
    TELNETCOUNT=`telnet ${server} | grep -v "Connection refused" | grep "Connected to" | grep -v grep | wc -l`

    if [ $TELNETCOUNT -eq 1 ] ; then
        # Telnet up!
        echo "Can connect via Telnet at ${server}"
        break
    else
        echo "Cannot connect to Zookeeper at ${server}"
    fi
    echo "Sleep ${delay}"
    sleep ${delay}
done

${command}
