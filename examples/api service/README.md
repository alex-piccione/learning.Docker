# api-server NodeJs application

Simple Node app that responsd to:

- GET / (HTML)
- GET /api/inso (JSON)

To run locally: `yarn start`

## Docker image creation and publication

Crete a Docker image from a Dockerfile  
`docker image build -t alessandropiccione/test-api-server:2.2 .` (run from where is the Dockerfile)  
`docker image build -t alessandropiccione/test-api-server:2.2 --file "./examples/api service/Dockerfile" "./examples/api service"`

Test it:  
`docker container run -d --name test-api-server -p 8010:3005 alessandropiccione/test-api-server:latest`
To remove the container: `docker rm test-api-server -f`

Open <http:/localhost:8006> or <http:/localhost:8006/api/info> in a browser.

Publish `docker image push alessandropiccione/test-api-server:2.2`  
Create Latest `docker tag alessandropiccione/test-api-server:2.2 alessandropiccione/test-api-server:latest`
Publish Latest `docker image push alessandropiccione/test-api-server:latest`
