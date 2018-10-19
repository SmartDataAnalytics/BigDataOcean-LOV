# BigDataOcean-LOV
BigDataOcean Metadata Repository (based on LOV)

- Start mongodb, elasticsearch, fuseki, and LOV in separate docker containers using docker-compose:
```sh 
$ docker-compose up
```
- Initialize LOV with data
```sh 
$ ./initLOV
```
- Update LOV when new data is inserted
```sh 
$ ./updateLOV
```
### Note:
Do not forget to initialize LOV.