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
    mongoimport -h mongodb -d bdo -c vocabularies --file vocabularies.json;
    mongoimport -h mongodb -d bdo -c pilots --file pilots.json'

# Update elasticsearch index
# It runs every day (86400 seconds) to update the bdo.n3 and bdo.nq and the elasticsearch index and last the endpoint data is updated
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/;
    while true; do ./mongo2rdf && ./create-index && ./index-lov; 
    cd /BDO/; cd ..; 
    /apache-jena-fuseki-3.4.0/bin/s-put http://fuseki:3030/bigdataocean/data http://localhost:3333/dataset/bdo BDO/lov/public/lov.n3;
    sleep 86400; done'
