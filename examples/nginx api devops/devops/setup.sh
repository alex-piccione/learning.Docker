# This file setup the production server

# /secrets is the container path linked to the Volume in the Dockerfile
#sed -i "s/$secretsFile:*^/secretsFile:\/secrets\/api-service.secrets.json,\n/" "api service/src/config.js"
#sed -i 's/aaa/bbb/' "api service/src/config.js"

## requires SSH comnnection opened

read -p "devop user:" devop_user
read -p "server ip: " server_ip

# or use already set defaults:
devop_user=$devop_user
server_ip=$mercury

## copy "/secrets/conf/api-service.secrets.json" to "/devop/conf/api-service/secrets.json"

# curly brackets are used to escape the variable followed by colon (:)
scp "/d/Programming/devop/config/learning-docker_api-service.config.json" $devop_user@${server_ip}:/devop/config/api-service/configuration.json

# another syntax for Windows
#scp "d:/Programming/devop/config/learning-docker_api-service.config.json" $user@${server_ip}:/devop/config/api-service/configuration.json


## copy deploy scripts

read -p "project root folder (parent of devops folder): " project_folder
# /d/Programming/Docker\ and\ Kubernetes/learning.Docker/examples/nginx\ api\ devops

#scp "$project_folder/devops/deploy.sh" $user@${server_ip}:/devop/scripts/api-service/deploy.sh
scp "$PWD/deploy.sh" $devop_user@${server_ip}:/devop/scripts/api-service/deploy.sh
ssh $user@${server_ip} chmod g+wx /devop/scripts/api-service/deploy.sh

#cp compose.yml "/d/Programming/devop/sripts/api-service/compose.yml"
#scp "$project_folder/devops/compose.yml" $user@${server_ip}:/devop/scripts/api-service/compose.yml
scp "$PWD/compose.yml" $devop_user@${server_ip}:/devop/scripts/api-service/compose.yml