# Docker Images

- `hbase/Dockerfile`
- `java/Dockerfile`


# Work with IntelliJ
**System Requirements**
- Windows
- Docker toolbox with VirtualBox
- [Unison](https://www.cis.upenn.edu/~bcpierce/unison/) file synchronizer, a command line tool for synchronizing into a container
- Bash on git (Windows)

**Prerequisite**

- Start docker by `Docker Quickstart Terminal` 

## Read me first
- ถ้าเอา opentsdb มารัน บน windows แก้ไฟล์ pom.xml.in ก่อน โดยแก้จาก `<executable>build-aux/gen_build_data.sh</executable>` เป็น `<executable>build-aux/gen_build_data.bat</executable>` เพราะว่า windows ไม่สามารถรันไฟล์ `sh` ได้ (ซึ่งในไฟล์นี้มีคำสั่ง `bash gen_build_data.sh` อยู่เพื่อแก้ปัญหานี้)
- ถ้า build แล้วทำงานผิดพลาดให้ตรวจสอบ Path ให้ดี และมั่นใจว่าทุกครั้งก่อน build ต่างสภาพแวดล้อมนั้นให้ลบไฟล์ที่ถูก build ออกไปให้หมด โดยใช้ `git clean -X -f` ในการลบทุกอย่างที่อยู่ใน `.gitignore` ออกไป 

## Setup default batch for docker environment
1. Open widows `Run/Debug Configurations`
2. In left panel, go to `Defaults` > `Batch`
3. Run `docker-machine env` to see what variables are needed to set, for example.

```
SET DOCKER_TLS_VERIFY=1
SET DOCKER_HOST=tcp://192.168.99.100:2376
SET DOCKER_CERT_PATH=C:\Users\mildronize\.docker\machine\machines\default
SET DOCKER_MACHINE_NAME=default
SET COMPOSE_CONVERT_WINDOWS_PATHS=true
REM Run this command to configure your shell:
REM     @FOR /f "tokens=*" %i IN ('docker-machine env') DO @%i
```

4. Go back to `Run/Debug Configurations` window
5. Using the 5 variables following step 3: `DOCKER_TLS_VERIFY`, `DOCKER_HOST`, `DOCKER_CERT_PATH`, `DOCKER_MACHINE_NAME` and `COMPOSE_CONVERT_WINDOWS_PATHS` set them into `Environment variables`

## A list of Batch
- *- build.sh*: `docker exec tsdb bash -c "chmod 777 -R * && ./build.sh"`
- *- build.sh pom.xml*: `exec tsdb bash -c "chmod 777 -R * && ./build.sh pom.xml"`
- *- build-aux/create-src-dir-overlay.sh*: For copying all Java sources into path `src-main` and `src-test` in order to run test with Maven `docker exec tsdb bash -c "./build-aux/create-src-dir-overlay.sh"`
- *- Sync*: Using `unsion` command line for synchronizing between host files and docker container. Before using this batch, you should setup a data container following [unison on docker site](https://github.com/leighmcculloch/docker-unison) `bash -c "unison . socket://$(docker-machine ip):5000/ -follow 'Regex .*' -ignore 'Path .git' -ignore 'Path .idea' -auto -batch"`
    - Use `bash` because it cannot run unison on windows with current path for synchronizing. 
        - Work: `bash -c "unison ."`.
        - Don't work: `unison .` (on `cmd`)
    - Synchronize following socket with host and port of unison server. for example. `socket://$(docker-machine ip):5000/`
    - `-follow` argument is set for copying the real file if the file is symbolic link
    - `-ignore 'Path .git' -ignore 'Path .idea'` Ignore path with `.git` and `.idea`
    - `-auto -batch` for automatically synchronizion, if some files are conflict, the files will be ignored. If there is any conflict, please run `unsion` manually by removing `-batch`. For example `bash -c "unison . socket://$(docker-machine ip):5000/ -follow 'Regex .*' -ignore 'Path .git' -ignore 'Path .idea' -auto`

- *Waiting for hbase*: `docker exec -i tsdb /entrypoint.sh`
- *Run TSDB*: `docker exec -d -i tsdb /opt/bin/start_opentsdb.sh`
- *Clean*: For cleaning all built files in `.gitignores` `git clean -X -f`
- *Build*: Before lauch:
    - **- Sync**
    - **- build.sh**
    - **- Sync**
- *Generate pom.xml*: Before lauch:
    - **- Sync**
    - **- build.sh pom.xml**
    - **- Sync**
- *Copy src to dir overlay*: Before lauch:
    - **- Sync**
    - **- build-aux/create-src-dir-overlay.sh**
    - **- Sync**


# Run TSDB for dev

```
docker-compose up -d tsdb-dev
```


# Run TSDB for dev (old)
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


