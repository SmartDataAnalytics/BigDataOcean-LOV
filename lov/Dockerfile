FROM openjdk:8-jdk-stretch

RUN apt-get update \
  && apt-get install -y maven unzip build-essential python-pip

# Install vim
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]

# Install flask and guepy
RUN pip install Flask
RUN pip install quepy

# Install Node.js
RUN apt-get update \
  && apt-get install -y software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install nodejs

# Install lov
WORKDIR /BDO
RUN git clone https://github.com/EIS-Bonn/lov.git
WORKDIR /BDO/lov/setup/
RUN unzip versions.zip && mv versions/ /BDO/lov
WORKDIR /BDO/lov/public/
RUN unzip bdo.zip
WORKDIR /BDO/lov/
RUN npm install

# Install lovScripts
WORKDIR /BDO
RUN git clone https://github.com/EIS-Bonn/lovScripts.git
RUN mkdir -p /scripts/log && touch /scripts/log/server.log
RUN cd lovScripts/ && mvn install -Dmaven.test.skip=true 

# Install QA4LOV
WORKDIR /BDO
RUN git clone https://github.com/EIS-Bonn/QA4LOV.git

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update && apt-get install -y mongodb-org

# Install fuseki
RUN apt-get install -y ruby-full
WORKDIR /
RUN wget http://archive.apache.org/dist/jena/binaries/apache-jena-fuseki-3.9.0.zip
RUN unzip apache-jena-fuseki-3.9.0.zip && rm apache-jena-fuseki-3.9.0.zip
RUN chmod +x apache-jena-fuseki-3.9.0/bin/s-*

# Set timezone 
ENV TZ=Europe/Athens
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /BDO/lov/
CMD npm start
