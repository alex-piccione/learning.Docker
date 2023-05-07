# This file setup the production server

# /secrets is the container path linked to the Volume in the Dockerfile
#sed -i "s/$secretsFile:*^/secretsFile:\/secrets\/api-service.secrets.json,\n/" "api service/src/config.js"
#sed -i 's/aaa/bbb/' "api service/src/config.js"

## requires SSH comnnection opened

read -p "devop user:" devop_user
read -p "server ip: " server_ip

# or use already set defaults: ($deveop_user & $mercury)
devop_user=$devop_user
server_ip=$mercury

## copy "/secrets/conf/api-service.secrets.json" to "/devop/conf/api-service/secrets.json"

# curly brackets are used to escape the variable followed by colon (:)
scp "/d/Programming/devop/learning-docker/api-service/config.json" $devop_user@${server_ip}:/devop/learning-docker/api-service/config.json
#Inside a SSH session: ``chgrp devops /devop/learning-docker``
#Inside a SSH session: ``chgrp devops /devop/learning-docker/api-service``
# Error like "No such file or directory" can be due to missing permissions

# another syntax for Windows
#scp "d:/Programming/devop/config/learning-docker_api-service.config.json" $user@${server_ip}:/devop/config/api-service/configuration.json


## copy deploy scripts

read -p "project root folder (parent of "devops" folder): " project_folder
# /d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops

scp "$project_folder/devops/deploy.sh" $devop_user@${server_ip}:/devop/learning-docker/api-service/deploy.sh
ssh $devop_user@${server_ip} chmod g+wx /devop/learning-docker/api-service/deploy.sh

#cp compose.yml "/d/Programming/devop/sripts/api-service/compose.yml"
scp "$project_folder/devops/compose.template.yml" $devop_user@${server_ip}:/devop/learning-docker/api-service/compose.template.yml
ssh $devop_user@${server_ip} chgrp devops /devop/learning-docker/api-service/compose.template.yml

## give devop user permission for pull ECR image


# test top launch the deploy script
#ssh $devop_user@${server_ip} /devop/learning-docker/api-service/deploy.sh