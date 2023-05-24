# This file runs the deploy on production server (host)

# move to root directory
cd /devop/learning-docker/api-service

echo "Replace Docker compose template with rith images"
# replace image template with real value
api_docker_image=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/test-api-service:latest
nginx_docker_image=${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/test-api-service-nginx:latest

# use double quote to expand env variable correctly
#sed "s/{docker-image}/$docker_image/g" compose.template.yml > compose.yml
echo "replace docker image with '$api_docker_image'"
sed "s|{api-docker-image}|$api_docker_image|g" compose.template.yml > compose.temp.yml

echo "replace docker image with '$nginx_docker_image'"
sed "s|{nginx-docker-image}|$nginx_docker_image|g" compose.temp.yml > compose.yml


echo "Run docker compose up (detached)"

# need to have sts:assumeRole permission and Trust relationship set on Role
echo Login to AWS ECR
# Get an authentication token for the ECR registry
DOCKER_PASSWORD=$(aws --profile learning ecr get-login-password --region ${AWS_REGION})

# Use the authentication token to log in to the ECR registry
#docker login -u AWS -p ${DOCKER_PASSWORD} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
echo ${DOCKER_PASSWORD} | docker login -u AWS ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com


## I'm getting this error: 
## Error: Cannot perform an interactive login from a non TTY device

## another way (not tested):
## aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${region}.amazonaws.com

# new docker "compose" command, replacing the docker-compose
docker compose -f /devop/learning-docker/api-service/compose.yml up --build -d
