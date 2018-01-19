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
### Note:
Do not forget to initialize LOV, the bash contains a repeat cycle that permits to update the system every day.


Then visit http://localhost:3333/
