# Nginx on Docker automated

Procedure, scripts and commands to execute Continuous Delivery using containers on a single Docker instance.  
We try to deploy a web app with a Nginx that makes a load balancer for the 2 instances.

## Initial setup

### Setup a dedicated user

SSH authentication within Public Key must be in place.

```PowerShell
$server_ip = "192.168.1.8"
$user = Read-Host "Enter username"
ssh $user@$server_ip
```
or  
```bash
read -p "Server IP:" server_ip
read -p "User:" user
ssh $user@$server_ip
```

List users with ``cat /etc/paswd``.

Server should have a user and space to execute the operations.  
Create a "devops" group: `sudo groupadd devops`
Create a "devop" user: `sudo useradd -m -g devops -s /bin/bash devop && sudo passwd devop`
Add user to "sudoers": `sudo usermod -aG sudo devop`
Add user to "docker" group: `sudo usermod -aG docker devop`

### Set Secrets file and scripts for the web app

Create the _/devop_ directory: `sudo mkdir /devop && sudo chown devop /devop && sudo chgrp devops /devop`
Create the other folders: (not sudo) `mkdir /devop/secrets && mkdir /devop/scripts`
Check the owner: `ls /devops/ -la`

```
drwxr-xr-x  4 devop devops 4096 Jul 30 21:08 .
drwxr-xr-x 23 root  root   4096 Jul 30 17:48 ..
drwxr-xr-x  2 devop devops 4096 Jul 30 21:08 scripts
drwxr-xr-x  2 devop devops 4096 Jul 30 21:06 secrets
```

Server should have this scripts and files:

From _examples_ folder:

```PowerShell
$server_ip="192.168.1.8"
$user="alex"
# curly brackets are used to escape the variable followed by colon (:)
scp "api service/.secrets/secrets.prod.json" $user@${server_ip}:/devops/secrets/api-service.secrets.json
scp "devops/deploy.api-service.sh" $user@${server_ip}:/devops/scripts/deploy.api-service.sh
```

## Deploy

Script to run when new version is deployed:

```bash
`docker container rm test-api-1 -f`
`docker container rm test-api-2 -f`
`docker run -d --name test-api-1 --net=test-network --ip=172.20.0.10 -v secrets-vol:/secrets alessandropiccione/test-api-service:latest`
`docker run -d --name test-api-2 --net=test-network --ip=172.20.0.11 -v /devops/secrets:/secrets alessandropiccione/test-api-service:latest`
```

## Other operation not required for now

Add the volume to the container _run_ if it is not added by the Dockerfile:
`-v /path/in/host:/path/in/container`  
`-v /home/alex/secrets:/secrets`

docker run -d --name test-api-1 --net=test-network --ip=172.20.0.10 -v /devops/secrets:/secrets alessandropiccione/test-api-service:latest

Chaneg the path in _config.js_.
In the deploy script do this:

_deploy-api-service.sh_

```bash
sed -i "s/secretsFile:*/secretsFile: /secrets/api-service.secrets.json" src/config.json
```
