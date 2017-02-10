FROM java:oraclejdk-8
# FROM java:openjdk-8
MAINTAINER Thada Wangthammang <mildronize@gmail.com>

ENV HBASE_HOME      /opt/hbase

ENV TSDB_VERSION    2.2.0
ENV TSDB_HOME       /opt/opentsdb/

ENV PATH            $PATH:${HBASE_HOME}/sbin:${HBASE_HOME}/bin:${TSDB_HOME}/opentsdb-${TSDB_VERSION}/build

# install GNUplot and clean cache
RUN \
    apt-get update && \
    apt-get install -y gnuplot unzip autoconf make python telnet && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${TSDB_HOME} ${HBASE_HOME}
WORKDIR ${TSDB_HOME}
#Install OpenTSDB and scripts

RUN wget --no-check-certificate -O v${TSDB_VERSION}.zip https://github.com/OpenTSDB/opentsdb/archive/v${TSDB_VERSION}.zip && \
    unzip v${TSDB_VERSION}.zip && \
    rm v${TSDB_VERSION}.zip
WORKDIR ${TSDB_HOME}/opentsdb-${TSDB_VERSION}
RUN ./build.sh

ADD opentsdb.conf ${TSDB_HOME}

ADD start_opentsdb.sh /opt/bin/
ADD create_tsdb_tables.sh /opt/bin/
ADD entrypoint.sh /opt/bin/
RUN chmod 755 /opt/bin/*.sh

RUN sed -i "s#{{TSDB_VERSION}}#$TSDB_VERSION#g;" /opt/bin/start_opentsdb.sh && \
    sed -i "s#{{TSDB_VERSION}}#$TSDB_VERSION#g;" /opt/bin/create_tsdb_tables.sh

# OpenTSDB GUI
EXPOSE 4242

WORKDIR ${TSDB_HOME}

CMD ["/opt/bin/entrypoint.sh"]
