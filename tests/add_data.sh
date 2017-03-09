#!/usr/bin/env bash

$tsdb_cli_path="./tsdb"
$service_name="tsdb-dev"
$import_file="dps-1"

$container_id=`docker-compose ps -q $service_name`

docker cp ./data/$import_file $container_id:/opt/opentsdb/opentsdb-2.3.0/data \ 
&& docker-compose exec $service_name $tsdb_cli_path import ./data/$import_file