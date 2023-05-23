# Nginx Webapp Devops

This is a full example of deploy a Nginx load balancer for a multi instance web app.  
More than that there is everything to deploy the service from GitHub Actions.  

![images](diagrams/Infrastructure%20with%20NGINX.drawio.png)
  
GitHub Actions: https://github.com/alex-piccione/learning.Docker/actions 
AWS Elastic Container Repository: test-api-service

This is the **local root path**: 
``cd /d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops/``
``cd "D:\Programming\Docker and Kubernetes\learning.Docker\examples\nginx api devops"``

TODO:

- [x] Able to run the API service locally
  - [x] README contains the command(s) to start the service
- [x] API Service should expose /api/info endpoint that return the version
- [x] Bash command to copy secrets/configuration file to host server
- [x] GitHub action to create images and publish on some Docker image repository
  - [x] "deploy api-service test image.yml"
  - [x] API service image
  - [x] Nginx image 
- [x] Setup instructions to prepare server
  - [x] Documented
  - [x] Setup tested
- [ ] Setup Nginx to run both the containers
- [ ] ...
- [ ] GitHub action to deploy containers the first time
  - [ ] test: when removing containers on docker, it will recreate them
- [ ] GitHub action to update containers on deploy
  - [ ] test: after deploy, the services are updated with new version
- [ ] GitHub action to run Dockerfile or Docker-compose ?  
  - docker-compose because it manages all in one place (network, configs etc...)
  - [ ] docker-compose file can be run locally

## How to setup local environment

Api server use secrets from a configuration file.  
The configuration file path and server port is passed through Environment variables, see _api service/config.js_.   

Go to local root path.
``sh
cd "api service"
yarn install
``

## How to run the API service locally

1. In local NodejS
Go to local root path (currently _/examples/nginx api devops/_).
run: ``./start-api.sh``

2. Docker compose
```sh
docker compose -f compose.local.yaml
```

[api service/README.md](api%20service/README.md) contains instructions to use the service.

## How to setup server

Copy the config file on the server:
``scp "/d/secrets/api-service.secrets.json" $user@${server_ip}:/devop/conf/api-service/secrets.json``

Install Docker Compose on the server.

(Ubuntu):
``sudo apt-get update``
``sudo apt-get install docker-compose-plugin``
check with: ``docker-compose version``


## How to run all the services

From local root:
``docker-compose up``
``docker-compose -f compose.local.yml up -d --force-recreate``
or new syntax
``docker compose -f compose.local.yml up -d --force-recreate``

check with
``docker ps``

## Deploy to production

### Setup

Host file structure

```
/devop
  /config
    /api_service/conf.json
  /data
    /api_service_mongodb
  /logs
    /api_service/(log files)
  /scripts
    /api_service
```

### GitHub action

