# Nginx Webapp Devops

This is a full example of deploy a Nginx load balancer for a multi instance web app.  
More than that, there is everything to deploy the service from GitHub Actions.  
[![Create API-service Docker image](https://github.com/alex-piccione/learning.Docker/actions/workflows/deploy%20api-devop%20image.yml/badge.svg)](https://github.com/alex-piccione/learning.Docker/actions/workflows/deploy%20api-devop%20image.yml)

![images](images/Infrastructure%20with%20NGINX.drawio.png)
  
GitHub Actions: https://github.com/alex-piccione/learning.Docker/actions 
AWS Elastic Container Repository: test-api-service

This is the **local root path** used for local tests: 
``cd /d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops/``
``cd "D:\Programming\Docker and Kubernetes\learning.Docker\examples\nginx api devops"``

## How it works

Some setup on AWS, GitHub and the host machine as to be done in advance.  
An AWS role with ECR permissions is required.
The AWS role has to be set on the host machine too.  
An SSH key as to be set on the host machine.  
  
The API service is a Nodejs application.  
There is a GitHub action that create a Docker image and publish it to AWS ECR.  
It requires the AWS credentials of a role that has thye right permission for AWS ECR.  
It requires ECR already having the containers in the registry.  
  
There is a docker compose file in the _devop_ folder that run the containers.  


## TODO

- [x] Able to run the API service locally
  - [x] README contains the command(s) to start the service locally
- [x] API Service should expose /api/info endpoint that return the version
- [x] Bash command to copy secrets/configuration/scripts file to host server
- [x] GitHub action to create images and publish on some Docker image repository
  - [x] "deploy api-service.yml"
  - [x] "deploy api-service-nginx.yml"
  - [x] API service image
  - [x] Nginx image 
- [x] Setup instructions to prepare server
  - [x] Documented
  - [x] Setup tested
- [ ] Setup Nginx to run both the containers
- [ ] ...
- [x] GitHub action to upate and start containers
  - [ ] test: when removing containers on docker, it will recreate them
  - [ ] test: when update version, it will show up new version
- [ ] GitHub action to update deploy version
  - [ ] test: after deploy, the services are updated with new version
- [x] Docker Compose
  - [x] API service
  - [ ] Nginx
  - [x] Local version to be run locally
  - [ ] SSH
  - [ ] Domain

## How to setup local environment

Api server uses secrets from a configuration file.  
The configuration file path and server port is passed through Environment variables, see _api service/config.js_.   

Go to local root path.
``sh
cd "api service"
yarn install
``

## How to run the API service locally

1. In local NodejS
Go to local root path (currently _/examples/nginx api devops/_).
run: ``./devop/start-api.sh``

2. Docker compose
```sh
docker compose -f devop/compose.local.yml up --build
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
``docker compose -f compose.local.yml up -d --build``

check with
``docker ps``

## Deploy to production

### Setup

Host file structure (obsolete)

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

### NGINX

Certificate?


### GitHub action

_deploy api-service image.yml_