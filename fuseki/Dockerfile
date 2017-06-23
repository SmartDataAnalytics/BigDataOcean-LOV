FROM java:8

RUN apt-get update && apt-get install -y wget unzip

RUN wget http://www.gutscheine.org/mirror/apache/jena/binaries/apache-jena-fuseki-2.6.0.zip
RUN unzip apache-jena-fuseki-2.6.0.zip && rm apache-jena-fuseki-2.6.0.zip
RUN chmod +x apache-jena-fuseki-2.6.0/fuseki-server
WORKDIR /apache-jena-fuseki-2.6.0
ENTRYPOINT ["./fuseki-server"]
CMD ["--update", "--mem", "/bigdataocean"]
