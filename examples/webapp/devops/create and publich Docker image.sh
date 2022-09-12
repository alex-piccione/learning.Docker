#!/bin/bash

# Build the image from file Dockerfile.3
# run this from the root folder of the project
docker image build -t alessandropiccione/test-api-service:0.1.0 -f ./devops/Dockerfile.3 .

# test it locally
docker container run -d -p 81:3000 --name test-api-service alessandropiccione/test-api-service:0.1.0 

curl http://localhost:81 
should return "Hello World"

# publish image 
docker tag alessandropiccione/test-api-service:0.1.0 alessandropiccione/test-api-service:latest
docker push alessandropiccione/test-api-service:latest