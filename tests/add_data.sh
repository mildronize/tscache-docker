#!/usr/bin/env bash

tsdb_cli_path="./tsdb"
service_name="tsdb-test"
import_file="dps-1"
docker_compose_path="docker-compose-test.yml"

container_id=`docker-compose --file $docker_compose_path ps -q $service_name`

pwd

docker cp ./data/$import_file $container_id:/opt/opentsdb/opentsdb-2.3.0/data \ 
&& docker-compose --file $docker_compose_path exec $service_name $tsdb_cli_path import ./data/$import_file