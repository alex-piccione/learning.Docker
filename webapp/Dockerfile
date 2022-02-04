# Linux x64 witin Node (and nothing else!)
FROM node:current-alpine

# Add some metadata
#LABEL bla bla 

# Create directory in container image for app code
RUN mkdir /usr/src/app

# Copy the app code (.) to the app directory
#COPY . /usr/src/app

# Copy the builded app code (./build) to the app directory
COPY ./build /usr/src/app

# Set working directory context
WORKDIR /usr/src/app

# Install dependencies
# RUN yarn install

# Command for container to execute
ENTRYPOINT [ "node", "app.js" ]
