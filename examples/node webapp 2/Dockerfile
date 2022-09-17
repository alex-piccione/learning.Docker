# Builder image, build the executable
FROM node:16-alpine 

WORKDIR /app
COPY . . 
RUN yarn install

# not required, it's only an indication for who use the Dockerfile
#EXPOSE 3000 

# CMD ["node", "app.js"]
ENTRYPOINT ["node", "app.js"]
