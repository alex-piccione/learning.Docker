# This file runs the deploy on production server (host)

# replace image template with real value
cd /devop/learning-docker/api-service
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
echo login to AWS ECR
# Get an authentication token for the ECR registry
DOCKER_PASSWORD=$(aws --profile learning ecr get-login-password --region ${AWS_REGION})

# Use the authentication token to log in to the ECR registry
#docker login -u AWS -p ${DOCKER_PASSWORD} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com
echo ${DOCKER_PASSWORD} | login -u AWS ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

# new docker "compose" command, replacing the docker-compose
docker compose -f /devop/learning-docker/api-service/compose.yml up --build -d
