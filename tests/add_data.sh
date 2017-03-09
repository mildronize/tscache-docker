#!/usr/bin/env bash

set -x

tsdb_cli_path="build/tsdb"
service_name="tsdb-test"
import_file="dps-1"
docker_compose_path="docker-compose-test.yml"

container_id=`docker-compose --file $docker_compose_path ps -q $service_name`

pwd

docker cp ./tests/data/$import_file $container_id:/opt/opentsdb/opentsdb-2.3.0/ && docker exec -i $container_id $tsdb_cli_path import ./$import_file

