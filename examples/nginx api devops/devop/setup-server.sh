### This file setup the production server (Host) ###

# /secrets is the container path linked to the Volume in the Dockerfile
#sed -i "s/$secretsFile:*^/secretsFile:\/secrets\/api-service.secrets.json,\n/" "api service/src/config.js"
#sed -i 's/aaa/bbb/' "api service/src/config.js"

# SSH connection
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


# test /cert folder is accessible inside nginx container
docker exec -it learning-test-nginx /bin/bash
ls /cert

### Copy Nginx config
# irong, like SSL not set it cannot start and is impossible to investigate
```bash
scp "$project_folder/devop/nginx.conf" $devop_user@${server_ip}:/devop/learning-docker/nginx/nginx.conf
ssh $devop_user@${server_ip} docker restart learning-test-nginx
```

### Setup the Certificate with Certbot

# create the directory where Certbot set the challenge
```bash
ssh $devop_user@${server_ip} mkdir /devop/learning-docker/nginx/wwwroot
ssh $devop_user@${server_ip} mkdir /devop/learning-docker/nginx/wwwroot/.well-known/acme-challenge -p
```

# run the command to create the cert the first time
# It requires teh port 80 to work
```bash
certbot certonly --webroot -d test.monei.it --webroot-path /devop/learning-docker/nginx/wwwroot

certbot_email=<your eamil>

cert=/devop/learning-docker/nginx/cert
certbot certonly --webroot -d test.monei.it \
    --webroot-path /devop/learning-docker/nginx/wwwroot \
    --config-dir $cert/config \
    --work-dir $cert/work \
    --logs-dir $cert/logs \
    -m $certbot_email

# cleanup symbolik link, nginx cannot read them
# ... maybe no more required after moving disable_symlinks off; in the right place
#cd $cert/live/test.monei.it/config
#mv cert.pem cert.pem__
#cp cert.pem__ cert.pem
#mv privkey.pem privkey.pem__
#cp privkey.pem__ privkey.pem
```
# it creates cert.pem  chain.pem  fullchain.pem  privkey.pem  README in /etc/letsencrypt/live/test.monei.it
# Using "sudo" THEM ARE NOT ACCESSIBLE FOR DEVOP USER !!!

#> Certificate is saved at: /devop/learning-docker/nginx/cert/config/live/test.monei.it/cert.pem
#> Key is saved at:         /devop/learning-docker/nginx/cert/config/live/test.monei.it/privkey.pem

# FILES ARE CREATED AS SYMBOLIK LINK, nginx cannot read them neither with disable_symlinks off; directive !!!

docker exec -it learning-text-nginx ls /devop/learning-docker/nginx/cert/config/live/test.monei.it


```bash
ssh $devop_user@${server_ip} mkdir /etc/letsencrypt/live/test.monei.it/* mkdir /devop/learning-docker/nginx/cert
ssh $devop_user@${server_ip} mv /etc/letsencrypt/live/test.monei.it/* /devop/learning-docker/nginx/cert
```


