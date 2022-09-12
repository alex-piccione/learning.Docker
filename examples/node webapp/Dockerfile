# Builder image, build the executable
FROM node:16-alpine 

WORKDIR /app
COPY . . 
RUN yarn install

# CMD ["node", "app.js"]
ENTRYPOINT ["node", "app.js"]
