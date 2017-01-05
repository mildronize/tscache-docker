#!/bin/bash

export COMPRESSION="NONE"
export HBASE_HOME=/opt/hbase
export TSDB_VERSION="::TSDB_VERSION::"

cd /opt/opentsdb/opentsdb-${TSDB_VERSION}/
./src/create_table.sh
touch /opt/opentsdb_tables_created.txt
