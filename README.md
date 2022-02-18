# learning.docker
Personal study of Docker  
[![Create Docker image](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy.yml/badge.svg)](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy.yml)


## Courses

Pluralsight [Docker fundamentals for developer](https://app.pluralsight.com/paths/skill/docker-fundamentals-for-developers): [_____]


## Learned & To Learn

- [X] Image list, build, delete, push
- [X] Container run
- [ ] Docker Compose
- [ ] Docker Swarm
- [ ] Docker Services
- [ ] Docker Stacks


## Build an image

``docker image build`` or ``docker build``

docker image build -t {name}:{tag} {Dockerfile path}
docker image build -t {user_id/repository}:{image} {Dockerfile path}

``
docker image build -t alessandropiccione/test-webapp:3 .
docker image build -t alessandropiccione/test-webapp:latest .
``

## Publish an image
``docker image push {image:tag}``

``
docker image push alessandropiccione/test-webapp:3
docker image push alessandropiccione/test-webapp:latest
``

1ccaf2dc393a0ae01ec89f50
docker login -u alessandropiccione --password-stdin cloud.canister.io:5000
echo 1ccaf2dc393a0ae01ec89f50 docker login -u alessandropiccione --password-stdin cloud.canister.io:5000
docker   push cloud.canister.io:5000/alessandropiccione/test-webapp:4.3-alfa


## Delete an image 
``docker image rm {image_name}``
``docker image rm {image_id}``

## Run a container
``docker container run``
- -d = run in the background (detached)
- --name {name}
- -p {local host}:{container host} port mapping

``
docker container run -d --name test_web -p 8006:8005 alessandropiccione/test-webapp:3
``

dockerhub is the default if we don't pass a URL registry. 


## List containers
docker container ls -a

## Delete a container 
``docker container stop {container_id|container_name}`` to stop it
``docker container rm {container_id|container_name}``
