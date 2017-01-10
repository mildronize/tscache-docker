# Local build
FROM hbase:1.2.4

MAINTAINER Thada Wangthammang <mildronize@gmail.com>

ENV TSDB_VERSION 2.2.0

RUN \
    apt-get update && \
    apt-get install -y unzip && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget --no-check-certificate -O v${TSDB_VERSION}.zip https://github.com/OpenTSDB/opentsdb/archive/v${TSDB_VERSION}.zip && \
    unzip v${TSDB_VERSION}.zip && \
    rm v${TSDB_VERSION}.zip

RUN mkdir -p /opt/bin
RUN cp /tmp/opentsdb-${TSDB_VERSION}/src/create_table.sh /opt/bin


ADD entrypoint.sh /opt/bin
RUN chmod 755 /opt/bin/*.sh

ENV HBASE_HOME /opt/hbase

CMD ["/opt/bin/entrypoint.sh"]
