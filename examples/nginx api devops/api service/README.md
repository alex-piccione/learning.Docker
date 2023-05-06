# api-server NodeJs application

## Setup

_config.js_ read configuration from a secret file stored on local machine.  
It has the same structure of _config.example.json_.
Refer to main README to know how to set it up.  

## API endpoints

Simple Node app that respond to:

- GET /         (HTML)
- GET /api/info (JSON)

To run locally: `yarn start`

## Docker image creation and publication

Crete a Docker image from a Dockerfile  
`docker image build -t alessandropiccione/test-api-server:2.2 .` (run from where is the Dockerfile)  
`docker image build -t alessandropiccione/test-api-server:2.2 --file "./examples/api service/Dockerfile" "./examples/api service"`

Test it:  
`docker container run -d --name test-api-service -p 8010:3005 alessandropiccione/test-api-service:latest`
To remove the container: `docker rm test-api-service -f`

Open <http:/localhost:8006> or <http:/localhost:8006/api/info> in a browser.

Publish `docker image push alessandropiccione/test-api-service:2.2`  
Create Latest `docker tag alessandropiccione/test-api-server:2.2 alessandropiccione/test-api-service:latest`
Publish Latest `docker image push alessandropiccione/test-api-service:latest`
