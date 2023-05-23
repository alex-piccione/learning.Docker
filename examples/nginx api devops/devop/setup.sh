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

## give devop user permission for pull ECR image


# test to launch the deploy script
#ssh $devop_user@${server_ip} /devop/learning-docker/api-service/deploy.sh


### Copy Nginx config

