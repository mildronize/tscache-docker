#!/bin/bash

# Replace config
sed -i "s#{{HBASE_ZOOKEEPER_QUORUM}}#$HBASE_ZOOKEEPER_QUORUM#g;" ${HBASE_HOME}/conf/hbase-site.xml

# /opt/hbase/bin/hbase master start
/opt/hbase/bin/start-hbase.sh
echo "Press Ctrl+C to stop instance."
sleep infinity
