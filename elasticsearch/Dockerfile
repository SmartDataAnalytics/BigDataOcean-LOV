FROM ubuntu
MAINTAINER Kris Pearson <kpearson@dataxu.com>
RUN apt-get update
RUN apt-get install -y openjdk-8-jre-headless wget
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN (cd /tmp && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.tar.gz -O elasticsearch.tar.gz && tar xf elasticsearch.tar.gz && mv elasticsearch-* /opt/elasticsearch)
RUN rm -rf /tmp/*

ENV cluster.name=elasticsearch \
    http.host=0.0.0.0 \
    transport.host=127.0.0.1 \
    xpack.security.enabled=false
EXPOSE 9200
EXPOSE 9300
VOLUME /opt/elasticsearch/data
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
CMD []
