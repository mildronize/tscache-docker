#!/bin/bash
export TSDB_VERSION="{{TSDB_VERSION}}"
# echo "Sleeping for 30 seconds to give HBase time to warm up"
# sleep 30 

# TODO: remove log files first

log_path="/var/log/opentsdb"
tsd_log="tsd.log"
created_table_log="created_table.log"

mkdir -p $log_path

if [ ! -e /opt/opentsdb_tables_created.txt ]; then
	echo "creating tsdb tables"
	bash /opt/bin/create_tsdb_tables.sh | tee $log_path/$created_table_log
	echo "created tsdb tables"	
fi

echo "starting opentsdb"
# if [ -e $tsd_log ] ; then
#     rm -f $tsd_log
# fi
/opt/opentsdb/opentsdb-${TSDB_VERSION}/build/tsdb tsd --port=4242 --staticroot=/opt/opentsdb/opentsdb-${TSDB_VERSION}/build/staticroot --cachedir=/tmp --auto-metric | tee $log_path/$tsd_log

# sleep infinity
