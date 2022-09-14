#!/bin/bash
# must be run from parent folder

echo "### docker build ###"
echo
docker image rm test-web-app:latest -f
docker build -t test-web-app:latest .
echo
echo 
echo "### docker run ###"
echo
docker container rm test-server -f
docker run -d -p 3001:3000 --name test-server test-web-app:latest  
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
