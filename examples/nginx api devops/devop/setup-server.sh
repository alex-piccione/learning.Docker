### This file setup the production server (Host) ###

# /secrets is the container path linked to the Volume in the Dockerfile
#sed -i "s/$secretsFile:*^/secretsFile:\/secrets\/api-service.secrets.json,\n/" "api service/src/config.js"
#sed -i 's/aaa/bbb/' "api service/src/config.js"

## Set some constants: server IP and devop user

# requires SSH connection opened
read -p "devop user:" devop_user
read -p "server ip: " server_ip
read -p "project root folder (parent of "devops" folder): " project_folder
# /d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops

# or use already set defaults: ($deveop_user & $mercury)
devop_user=$devop_user
server_ip=$mercury
project_folder=/d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops

### Copy API service config

# curly brackets are used to escape the variable followed by colon (:)
scp "/d/Programming/devop/learning-docker/api-service/config.json" $devop_user@${server_ip}:/devop/learning-docker/api-service/config.json
#Inside a SSH session: ``chgrp devops /devop/learning-docker``
#Inside a SSH session: ``chgrp devops /devop/learning-docker/api-service``
# Error like "No such file or directory" can be due to missing permissions

# another syntax for Windows
#scp "d:/Programming/devop/config/learning-docker_api-service.config.json" $user@${server_ip}:/devop/config/api-service/configuration.json


### Copy deploy scripts

scp "$project_folder/devop/deploy.sh" $devop_user@${server_ip}:/devop/learning-docker/api-service/deploy.sh
ssh $devop_user@${server_ip} chmod g+wx /devop/learning-docker/api-service/deploy.sh

#cp compose.yml "/d/Programming/devop/sripts/api-service/compose.yml"
scp "$project_folder/devop/compose.template.yml" $devop_user@${server_ip}:/devop/learning-docker/api-service/compose.template.yml
ssh $devop_user@${server_ip} chgrp devops /devop/learning-docker/api-service/compose.template.yml


# test to launch the deploy script
# ssh $devop_user@${server_ip} /devop/learning-docker/api-service/deploy.sh


### Copy Nginx config
# not needed because is in the Docker image


### Setup the HTTertificate with Certbot


# create the directory where Certbot set the challenge
```bash
ssh $devop_user@${server_ip} mkdir /devop/learning-docker/nginx/wwwroot
ssh $devop_user@${server_ip} mkdir /devop/learning-docker/nginx/wwwroot/.well-known/acme-challenge -p
```

# run the command to create the cert the first time
# It requires teh port 80 to work
```bash
certbot certonly --webroot -d test.monei.it --webroot-path /devop/learning-docker/nginx/wwwroot

certbot certonly --webroot -d test.monei.it \
--webroot-path /devop/learning-docker/nginx/wwwroot \
--config-dir /devop/learning-docker/nginx/cert/config \
--work-dir /devop/learning-docker/nginx/cert/work \
--logs-dir /devop/learning-docker/nginx/cert/logs \
-m alessandro.piccione.75@gmail.com

sudo mv /etc/letsencrypt/live/test.monei.it /etc/letsencrypt/live/test.monei.it__by_root
```
# it creates cert.pem  chain.pem  fullchain.pem  privkey.pem  README in /etc/letsencrypt/live/test.monei.it
# but THEM ARE NOT ACCESSIBLE FOR DEVOP USER !!! because I used "sudo"
# I changed the group of cert.pem and privkey.pem to "devops"


```bash
ssh $devop_user@${server_ip} mkdir /etc/letsencrypt/live/test.monei.it/* mkdir /devop/learning-docker/nginx/cert
ssh $devop_user@${server_ip} mv /etc/letsencrypt/live/test.monei.it/* /devop/learning-docker/nginx/cert
```


