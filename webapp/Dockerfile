# Linux x64 witin Node (and nothing else!)
FROM node:current-alpine

# Add some metadata
#LABEL bla bla 

# Create directory in container image for app code
RUN mkdir -p /usr/src/app

# Copy the app code (.) to the app directory
COPY . /usr/src/app

# Copy the builded app code (./build) to the app directory
#COPY ./build /usr/src/app

# Set working directory context
WORKDIR /usr/src/app

# Install dependencies
RUN yarn install && yarn build

# Command for container to execute
ENTRYPOINT [ "node", "/usr/src/app/build/app.js" ]
