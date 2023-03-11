#FROM alpine:latest
FROM node:18-alpine AS dependencies

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --omit=dev --frozen-lockfile

FROM node:18-alpine AS runner
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json ./package.json
COPY src/ ./

#VOLUME /devops/secrets:/secrets
# specify the container path to mount and being visible to the host
# it can be defined in the host using docker run -v or --mount flags
# using the "volumes" in docker-compose
VOLUME /secrets 

#ENV PORT 3005
EXPOSE 3005

CMD ["node", "./index.js"]
