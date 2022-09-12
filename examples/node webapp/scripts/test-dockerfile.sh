#!/bin/bash

echo docker build
docker image rm test-web-app:latest
docker build -t test-web-app:latest .

echo docker run
docker container rm test-server -f
docker run -d -p 3001:3000 --name test-server test-web-app:latest  
  
echo open http://localhost:3001/