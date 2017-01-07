#!/bin/bash
if [[ "$1" == "--clean-build" ]]; then
    echo Clean build enable
    options="--rm --force-rm"
fi

main(){
    echo Building java:oraclejdk-8
    docker build ${options} -t java:oraclejdk-8 java     || return 1
    echo Building hbase:1.2.4
    docker build ${options} -t hbase:1.2.4 hbase    || return 1
    echo Building hbase-for-opentsdb
    docker build ${options} -t hbase-for-opentsdb hbase-for-opentsdb    || return 1
    echo Building opentsdb:latest
    docker build ${options} -t opentsdb:latest  opentsdb || return 1
}

main $@
