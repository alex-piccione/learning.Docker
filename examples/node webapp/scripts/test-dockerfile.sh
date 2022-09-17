#!/bin/bash
# must be run from parent folder

host_secrets_path="/d/temp/secrets.json"
container_secrets_path="/var/secrets/secrets.json"

echo "### docker build ###"
echo
docker image rm test-web-app:latest -f
docker build --rm -t test-web-app:latest .
echo
echo 
echo "### docker run ###"
echo
docker container rm test-server -f
# production: --restart=unless-stopped
docker run -d -p 3001:3000 \
    --name test-server \
    --mount type=bind,source=$host_secrets_path,target=$container_secrets_path,readonly \
    test-web-app:latest  
echo
echo  
echo "### open http://localhost:3001 ###"
#x-www-browser http://localhost:3001
#xdg-open ttp://localhost:3001
#chrome http://localhost:3001
start http://localhost:3001
echo 
echo

function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

## Pause it ##
pause
