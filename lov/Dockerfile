FROM java:8

RUN apt-get update
RUN apt-get install -y maven unzip build-essential

# Installation of Node.js
RUN apt-get install -y python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install nodejs

# Installation of MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update && apt-get install -y mongodb-org-tools

# Install lov (frontend)
WORKDIR /BDO
RUN git clone https://github.com/EIS-Bonn/lov.git && cd lov/config
COPY /files/configPath.js configPath.js
WORKDIR /BDO/lov/setup/BDO_setup
CMD mongoimport -d bdo -c agents --type json --file agents.json && \
    mongoimport -d bdo -c languages --type json --file languages.json && \
    mongoimport -d bdo -c logsearches --file logsearches.json && \
    mongoimport -d bdo -c sessions --file sessions.json && \
    mongoimport -d bdo -c statlanguages --file statlanguages.json && \
    mongoimport -d bdo -c stattags --file stattags.json && \
    mongoimport -d bdo -c statvocabularies --file statvocabularies.json && \
    mongoimport -d bdo -c users --file users.json && \
    mongoimport -d bdo -c vocabularies --file vocabularies.json
WORKDIR /BDO/lov/setup/
RUN unzip versions.zip && mv versions/ /BDO/lov
WORKDIR /BDO/lov/
RUN npm install

# Install lov (backend)
WORKDIR /BDO
RUN git clone https://github.com/EIS-Bonn/lovScripts.git
COPY /files/log4j.properties /lovScripts/src/main/resources/log4j.properties 
RUN mkdir -p /scripts/log && touch /scripts/log/server.log
COPY /files/lov.config /lovScripts/lov.config
COPY /files/configPath.java lovScripts/src/main/java/org/lov/cli/configPath.java
RUN cd lovScripts/ && mvn install

# Update elasticsearch index
WORKDIR /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/ &
#RUN ./create-index && ./index-lov

# Upload graphs to fuseki
RUN apt-get install -y ruby-full
WORKDIR /
RUN wget http://www.gutscheine.org/mirror/apache/jena/binaries/apache-jena-fuseki-2.6.0.zip
RUN unzip apache-jena-fuseki-2.6.0.zip && rm apache-jena-fuseki-2.6.0.zip
RUN chmod +x apache-jena-fuseki-2.6.0/bin/s-*
WORKDIR /BDO/lov/public
RUN unzip bdo.zip
RUN /apache-jena-fuseki-2.6.0/bin/s-put http://172.17.0.4:3030/bigdataocean/data default lov.n3
RUN /apache-jena-fuseki-2.6.0/bin/s-put http://172.17.0.4:3030/bigdataocean/data default lov.nq

WORKDIR /BDO/lov/
CMD ["npm start"]
