#FROM alpine:latest
FROM node:18-alpine AS dependencies

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --frozen-lockfile

FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json ./package.json
COPY src/ ./

#RUN npm build

#RUN apt-get update \
#    && curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - \
#    && apt-get install -y nodejs
#    #&& apt-get install nodejs && apt-get install npm
# npm onot found
# 

ENV PORT 3000
EXPOSE 3000

CMD ["node", "./index.js"]
