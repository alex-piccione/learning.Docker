#FROM alpine:latest
FROM node:18-alpine AS dependencies

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --production --frozen-lockfile

FROM node:18-alpine AS builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json ./package.json
COPY src/ ./

#ENV PORT 3005
EXPOSE 3005

CMD ["node", "./index.js"]
