# Local oracle jdk 8 build
FROM java:oraclejdk-8
# FROM java:openjdk-8

MAINTAINER Thada Wangthammang <mildronize@gmail.com>

# Install HBase
ENV HBASE_HOME /opt/hbase
ENV HBASE_DATA /data/hbase
ENV HBASE_VERSION 1.2.4

RUN mkdir -p /data/hbase
RUN mkdir -p /opt/downloads
WORKDIR /opt/downloads
RUN \
    # wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \

    wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz && \

    tar xzvf hbase-${HBASE_VERSION}.bin.tar.gz && \
    mv hbase-${HBASE_VERSION} ${HBASE_HOME} && \
    rm hbase-${HBASE_VERSION}.bin.tar.gz

ADD hbase-site.xml ${HBASE_HOME}/conf/
ADD start_hbase.sh /opt/bin/

####  Publish ports
EXPOSE 16010
# For Zookeeper
EXPOSE 2181


WORKDIR ${HBASE_HOME}
VOLUME ["${HBASE_DATA}"]

CMD ["/opt/bin/start_hbase.sh"]


