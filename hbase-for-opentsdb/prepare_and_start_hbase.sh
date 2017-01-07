#!/bin/bash

# Setup timezone
ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime  && echo ${TIMEZONE} > /etc/timezone

/opt/bin/start_hbase.sh
/opt/bin/create_table.sh
touch /opt/opentsdb_tables_created.txt
