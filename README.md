# Learning Docker

Personal study of Docker  
[![Create Docker image](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy.yml/badge.svg)](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy.yml)

## Courses

Pluralsight [Docker fundamentals for developer](https://app.pluralsight.com/paths/skill/docker-fundamentals-for-developers): [_____]

## Learned & To Learn

- [X] Image list, build, delete, push
- [X] Container run
- [X] Cleanup image and use small start images
- [X] Multi-stage Docker build
- [ ] Docker Compose
- [X] Docker Swarm (service)
- [ ] Docker Stacks
- [X] Docker Network
- [ ] Docker Volumes/Bind mounts

## Build an image

``docker image build`` or ``docker build``  
**By default the docker build command will look for a Dockerfile at the root of the build context.**  
use _-f {dockerfile}_ to specify a different Dockerfile

docker image build -t {name}:{tag} {Dockerfile path}
docker image build -t {user_id/repository}:{image} {Dockerfile path}

```bash
# from webapp folder
docker image build -t alessandropiccione/test-webapp:3.1 .
docker image build -t alessandropiccione/test-webapp:latest .

# from root folder
docker image build -t alessandropiccione/test-webapp:3.1 ./webapp
```

## Publish an image

``docker image push {image:tag}``

```bash
docker image push alessandropiccione/test-webapp:3.1
docker image push alessandropiccione/test-webapp:latest

docker image push portfolio-app:latest
```

## Delete an image

``docker image rm {image_name}``
``docker image rm {image_id}``

## Run a container

``docker container run``

- -d = run in the background (detached)
- --name {name}
- -p {local host}:{container host} port mapping

``docker container run -d --name test_web -p 8006:8005 alessandropiccione/test-webapp:3``

dockerhub is the default if we don't pass a URL registry.  

To run a bash console in a container:  
``docker container run -it --name test_web alessandropiccione/test-webapp:3 /bin/bash``

### Pass variables to the container

``--env``, ``--env-file``
--env-file={file} works well with _.env_ files

## List containers

``docker container ls -a``

## Delete a container

``docker container stop {container_id|container_name}`` to stop it
``docker container rm {container_id|container_name}``
