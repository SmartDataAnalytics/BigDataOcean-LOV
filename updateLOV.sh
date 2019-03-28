# Update the elasticsearch data when new data is inserted in the system
docker exec -it bigdataoceanlov_lov_1 bash -c 'cd /BDO/lovScripts/target/lovscripts-cli/lovscripts/bin/;
    ./mongo2rdf && ./create-index && ./index-lov; 
    cd /BDO/; cd ..; 
    /apache-jena-fuseki-3.9.0/bin/s-put http://fuseki:3030/bigdataocean/data default BDO/lov/public/lov.n3'