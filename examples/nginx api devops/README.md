# Nginx Webapp Devops

This is a full example of deploy a Nginx load balancer for a multi instance web app.  

![images](diagrams/Infrastructure%20with%20NGINX.drawio.png)


TODO:

- [ ] Able to run the service locally
  - [ ] ac: README contains the command(s) to start the service
- [ ] Service should expose /version endpoint
- [x] GitHub action to create images and publish on some Docker Image repository
  - [x] "deploy api-service test image.yml"
  - [ ] API service image
  - [x] Nginx image 
- [ ] Setup Nginx to run both the containers
- [ ] ...
- [ ] GitHub action to deploy containers the first time
  - [ ] test: when removing containers on docker, it will recreate them
- [ ] GitHub action to update containers on deploy
  - [ ] test: after deploy, the services are updated with new version

## How to setup local environment

cd "api service"
npm install

## How to run the service locally

_start-api.sh_:
``sh
cd "api service"
npm start
open http://localhost:3000/version
``