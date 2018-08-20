# Import collections to MongoDB
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lov/setup/BDO_setup;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c logsearches --file logsearches.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c sessions --file sessions.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c statlanguages --file statlanguages.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c stattags --file stattags.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c statvocabularies --file statvocabularies.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c users --file users.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c agents --file agents.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c languages --file languages.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c vocabularies --file vocabularies.json;
    mongoimport --uri mongodb://admin:bd0@mongodb/bdo?authSource=admin -c pilots --file pilots.json'

# Update elasticsearch index
# It runs every day (86400 seconds) to update the bdo.n3 and bdo.nq and the elasticsearch index and last the endpoint data is updated
# docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/;
#    while true; do ./mongo2rdf && ./create-index && ./index-lov; 
#    cd /BDO/; cd ..; 
#    /apache-jena-fuseki-3.4.0/bin/s-put http://fuseki:3030/bigdataocean/data default BDO/lov/public/lov.n3;
#    sleep 86400; done'

docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/;
    ./mongo2rdf && ./create-index && ./index-lov; 
    cd /BDO/; cd ..; 
    /apache-jena-fuseki-3.4.0/bin/s-put http://fuseki:3030/bigdataocean/data default BDO/lov/public/lov.n3'

