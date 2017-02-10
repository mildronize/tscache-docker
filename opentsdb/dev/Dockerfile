# FROM java:oraclejdk-8
FROM openjdk:8
MAINTAINER Thada Wangthammang <mildronize@gmail.com>

ENV HBASE_HOME      /opt/hbase

ENV TSDB_VERSION    2.3.0
ENV TSDB_HOME       /opt/opentsdb/

ENV PATH            $PATH:${HBASE_HOME}/sbin:${HBASE_HOME}/bin:${TSDB_HOME}/opentsdb-${TSDB_VERSION}/build

RUN mkdir -p ${TSDB_HOME} ${HBASE_HOME}

# install GNUplot and clean cache
RUN apt-get update && apt-get install -y gnuplot unzip autoconf make python telnet \
        git zsh python-watchdog locales vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install my dev env
ENV DOTFILES_PATH       /root/.dotfiles
ENV DOTFILES_REMOTE     true
ENV SHELL               /usr/bin/zsh
RUN set -x \
    # fix locale following: http://unix.stackexchange.com/questions/246846/cant-generate-en-us-utf-8-locale
    && sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen && locale-gen \
    && git clone https://github.com/mildronize/dotfiles ${DOTFILES_PATH} \
    && cd ${DOTFILES_PATH} \
    && git checkout develop \
    && make zsh

ADD ./entrypoint.sh /
RUN chmod 755 /entrypoint.sh

WORKDIR ${TSDB_HOME}
CMD ["/entrypoint.sh"]
