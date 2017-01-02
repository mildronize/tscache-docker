FROM oracle-jdk8
# FROM java:openjdk-8
MAINTAINER Thada Wangthammang <mildronize@gmail.com>

ENV TIMEZONE Asia/Bangkok
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
# Install HBase
ENV HBASE_VERSION 1.2.4

RUN mkdir -p /data/hbase
RUN mkdir -p /opt/downloads
WORKDIR /opt/downloads
RUN \
    # wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \

    wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz && \

    tar xzvf hbase-${HBASE_VERSION}.bin.tar.gz && \
    mv hbase-${HBASE_VERSION} /opt/hbase && \
    rm hbase-${HBASE_VERSION}.bin.tar.gz

ADD hbase-site.xml /opt/hbase/conf/
ADD start_hbase.sh /opt/bin/

####  Publish ports
EXPOSE 16010
# For Zookeeper
EXPOSE 2181

VOLUME ["/data/hbase"]
WORKDIR /opt/hbase/bin

CMD ["/opt/bin/start_hbase.sh"]

