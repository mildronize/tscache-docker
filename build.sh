#!/bin/bash
if [[ "$1" == "--no-cache" ]]; then
    echo Clean build enable
    options="--no-cache"
fi

main(){
    echo Building java:oraclejdk-8
    docker build ${options} -t java:oraclejdk-8 java     || return 1

    echo Building hbase:1.2.4
    docker build ${options} -t hbase:1.2.4 hbase    || return 1
    
    echo Building opentsdb:latest
    docker build ${options} -t opentsdb:latest  opentsdb || return 1
}

main $@
