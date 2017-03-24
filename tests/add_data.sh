#!/usr/bin/env bash

set -x

type="$1"
# `test` or `dev`
if [ -z "$type" ]; then
    type="test"
fi

service_name="tsdb-$type"
import_file="dps-1"

tsdb_cli_path="build/tsdb"
tsdb_path="/opt/opentsdb/opentsdb-2.3.0"
docker_compose_path="docker-compose-$type.yml"

if [ "$type" == "dev" ]; then
    docker_compose_path="docker-compose.yml"
    tsdb_path="/home/dev/opentsdb-dev/opentsdb"
fi

tsdb_full_path="$tsdb_path/$tsdb_cli_path"
container_id=`docker-compose --file $docker_compose_path ps -q $service_name`

pwd

docker cp ./tests/data/$import_file $container_id:$tsdb_path && docker exec -i $container_id $tsdb_full_path mkmetric level && docker exec -i $container_id $tsdb_full_path import $tsdb_path/$import_file

