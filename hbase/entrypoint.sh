#!/bin/bash

# Replace config
sed -i "s#{{ZOOKEEPER_HOST}}#$ZOOKEEPER_HOST#g;" ${HBASE_HOME}/conf/hbase-site.xml

# /opt/hbase/bin/hbase master start
/opt/hbase/bin/start-hbase.sh
echo "Press Ctrl+C to stop instance."
sleep infinity
