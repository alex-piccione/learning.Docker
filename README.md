# Learning Docker

Personal study of Docker.  

[Examples/Nginx api devops](examples/nginx%20;api%20;devops/README.md)  

[![deploy node webapp 1.yml](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy node webapp 1.yml/badge.svg)](https://github.com/alex-piccione/learning.docker/actions/workflows/deploy node webapp 1.yml)

## Courses

Pluralsight [Docker fundamentals for developer](https://app.pluralsight.com/paths/skill/docker-fundamentals-for-developers): [_____]

## Learned & To Learn

- [X] Image list, build, delete, push
- [X] Container run
- [X] Cleanup image and use small start images
- [X] Multi-stage Docker build
- [x] Docker Compose
- [X] Docker Swarm (service) - [open](Readme%20Swarm.md)
- [ ] Docker Stacks
- [X] Docker Network
- [X] Docker Volumes/Bind mounts
- [ ] Setup Docker on a VPS - [open](Readme%20VPS.md)

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

``docker container run <image>`` or ``docker run <image>``

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


# Storing Docker Images on a Registry

## AWS Elastic Container Registry
1000 GB x month costs 0.1 USD.  
I'm trying to use the free tier.  
Region: eu-central-1 (Frankfurt)  
https://console.aws.amazon.com/ecr/home?region=eu-central-1  
Private address format: https://{aws_account_id}.dkr.ecr.{region}.amazonaws.com  

How to use ``docker login`` with a IAM user?  
https://aws.amazon.com/blogs/compute/authenticating-amazon-ecr-repositories-for-docker-cli-with-credential-helper/  
AWS ECR Guide: https://docs.aws.amazon.com/AmazonECR/latest/userguide/Registries.html#registry_auth

As usual... a nightmare!  

``docker login`` cannot be used straightforward, I also tried to give to the IAM user Console access.  
you need to obtain a "temporary password" from the AWS user credentials.  
Official documentation suggests to use ``aws ecr get-login-password`` command.
Fortunately ``aws ecr`` is a valid command in _ubuntu-latest_ image. 
If the command returns the error: 
> is not authorized to perform: ecr:GetAuthorizationToken on resource:* ...
you need to provide some permissions. 
I created this policy "ECR_get-login-password" and assigned to the group:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Resource": "*",
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken"
            ]
        }
    ]
}
```

docker push on GitHub Actions hanging and fails with EOF:  
https://stackoverflow.com/questions/70828205/pushing-an-image-to-ecr-getting-retrying-in-seconds  

Add policies to the repository...  
No, crea epolicy for ECR Actions (all resources) and add it to User Group of the user.  

In the end the "AmazonEC2ContainerRegistryPowerUser" policy contains ALL, also the get-login-password permission.

#### Consume images from ECR
In docker compose file I have:
``image: image: *********.dkr.ecr.eu-central-1.amazonaws.com/test-api-service:latest``  
In order to have this command working the use has to be authenticated and have permisison to pull image from ECR.  

To authenticate this is the AWS CLI command ``aws login``.  
To run this command the AWS CLI must be installed.    

To use a AWS Role instead of principal account, create a profile
``aws configure set role_arn arn:aws:iam::<account-id>:role/<role-name> --profile <profile-name>``
``aws configure set role_arn arn:aws:iam::151404309046:role/learning --profile learning``

I create a AWS profile "" in ~/.aws/config
```
[profile devop]
role_arn = arn:aws:iam:000000:role/devop
source_profile = default
```

~/.aws/credentials already exists and has the root user as default
```
[default]
aws_access_key_id = ***
aws_secret_access_key = ***
```

``aws --profile learning ecr get-login-password --region ${AWS_REGION}``


Error for 
An error occurred (AccessDeniedException) when calling the GetAuthorizationToken operation.  
And after solved that :
ecr:BatchGetImage
the usual AWS IAM nightmare.



## Known issues

Docker desktop fails to start a container:  
> Error invoking remote method 'docker-start-container': Error: (HTTP code 500) server error - Ports are not available: exposing port TCP 127.0.0.1:50505 -> 0.0.0.0:0: listen tcp 127.0.0.1:50505: bind: An attempt was made to access a socket in a way forbidden by its access permissions.
  
This error is related to Windows blocking some ports...  

### Solution
```powershell
# as Administrator
net stop winnat
docker start container_name
net start winnat
```
