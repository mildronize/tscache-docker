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
        git zsh python-watchdog locales \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install my dev env
ENV DOTFILES_PATH       /root/.dotfiles
ENV DOTFILES_REMOTE     true
RUN set -x && \
    git clone https://github.com/mildronize/dotfiles ${DOTFILES_PATH} && \
    cd ${DOTFILES_PATH} && \
    git checkout develop && \
    make zsh
# fix locale
RUN rm -f /etc/default/locale \
    && echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale \
    && dpkg-reconfigure --frontend=noninteractive locales


ADD entrypoint.sh /opt/bin/
RUN chmod 755 /opt/bin/entrypoint.sh

WORKDIR ${TSDB_HOME}
CMD ["/opt/bin/entrypoint.sh"]
