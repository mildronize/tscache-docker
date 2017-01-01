FROM oracle-jdk8

# Install HBase
ENV HBASE_VERSION 1.2.4

RUN mkdir -p /data/hbase
RUN mkdir -p /root/.profile.d
RUN mkdir -p /opt/downloads
WORKDIR /opt/downloads
RUN \
    # wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz && \
    wget -O hbase-${HBASE_VERSION}.bin.tar.gz http://www-us.apache.org/dist/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz && \

    tar xzvf hbase-${HBASE_VERSION}.bin.tar.gz && \
    mv hbase-${HBASE_VERSION} /opt/hbase && \
    rm hbase-${HBASE_VERSION}.bin.tar.gz

ADD hbase-site.xml /opt/hbase/conf/

EXPOSE 16010

WORKDIR /opt/hbase/bin
