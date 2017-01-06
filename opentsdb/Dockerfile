FROM java:oraclejdk-8
# FROM java:openjdk-8
MAINTAINER Thada Wangthammang <mildronize@gmail.com>

ENV TIMEZONE Asia/Bangkok
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# install GNUplot and clean cache
RUN \
    apt-get update && \
    apt-get install -y gnuplot unzip autoconf make python telnet && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ENV TSDB_VERSION 2.2.0
RUN mkdir /opt/opentsdb/
WORKDIR /opt/opentsdb/
#Install OpenTSDB and scripts

RUN wget --no-check-certificate -O v${TSDB_VERSION}.zip https://github.com/OpenTSDB/opentsdb/archive/v${TSDB_VERSION}.zip && \
    unzip v${TSDB_VERSION}.zip && \
    rm v${TSDB_VERSION}.zip
WORKDIR /opt/opentsdb/opentsdb-${TSDB_VERSION}
RUN ./build.sh

ADD start_opentsdb.sh /opt/bin/
ADD create_tsdb_tables.sh /opt/bin/
ADD wait_for_hbase.sh /opt/bin/
RUN chmod 755 /opt/bin/*.sh

RUN for i in /opt/bin/start_opentsdb.sh /opt/bin/create_tsdb_tables.sh; \
    do \
        sed -i "s#::TSDB_VERSION::#$TSDB_VERSION#g;" $i; \
    done

# OpenTSDB GUI
EXPOSE 4242

WORKDIR /opt/opentsdb/opentsdb-${TSDB_VERSION}/build

ADD opentsdb.conf /opt/opentsdb/

CMD ["/opt/bin/wait_for_hbase.sh"]
