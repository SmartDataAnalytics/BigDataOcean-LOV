# Import collections to MongoDB
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lov/setup/BDO_setup;
    mongoimport -h mongodb -d bdo -c logsearches --file logsearches.json;
    mongoimport -h mongodb -d bdo -c sessions --file sessions.json;
    mongoimport -h mongodb -d bdo -c statlanguages --file statlanguages.json;
    mongoimport -h mongodb -d bdo -c stattags --file stattags.json;
    mongoimport -h mongodb -d bdo -c statvocabularies --file statvocabularies.json;
    mongoimport -h mongodb -d bdo -c users --file users.json;
    mongoimport -h mongodb -d bdo -c agents --file agents.json;
    mongoimport -h mongodb -d bdo -c languages --file languages.json;
    mongoimport -h mongodb -d bdo -c vocabularies --file vocabularies.json'

# Update BDO fuseki graphs
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lov/public;
    ./fuseki-server --update --mem /bigdataocean;
    /apache-jena-fuseki-2.6.0/bin/s-put http://fuseki:3030/bigdataocean/data default lov.n3;
    /apache-jena-fuseki-2.6.0/bin/s-put http://fuseki:3030/bigdataocean/data default lov.nq'

# Update elasticsearch index
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/;
    ./create-index; ./index-lov'


