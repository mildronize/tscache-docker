# Docker Images

- `hbase/Dockerfile`
- `java/Dockerfile`


# Run TSDB for dev
```
# Build with the same `uid` and gid` of running host user into container
# Read more
# http://stackoverflow.com/questions/29377853/how-to-use-environment-variables-in-docker-compose
# https://github.com/docker/compose/issues/2111#issuecomment-176293224
uid=$UID gid=$GID docker-compose build tsdb-dev

# Up service
docker-compose up tsdb-dev

# Run root
docker exec -it -u root:root tsdb zsh
docker exec -it -u dev:dev tsdb zsh
```
