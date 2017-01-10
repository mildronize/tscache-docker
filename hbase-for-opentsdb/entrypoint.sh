#!/bin/bash

# Setup timezone
ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime  && echo ${TIMEZONE} > /etc/timezone

# Start HBase following https://hbase.apache.org/book.html#quickstart
# Start a HMaster, a single HRegionServer, and the ZooKeeper daemon
/opt/hbase/bin/start-hbase.sh

/opt/bin/create_table.sh
touch /opt/opentsdb_tables_created.txt
echo "Press Ctrl+C to stop instance."
sleep infinity
