FROM node:19-alpine AS dependencies

WORKDIR /app
#COPY package.json package-lock.json ./
COPY package.json yarn.lock ./
RUN yarn install --omit=dev --frozen-lockfile

FROM node:19-alpine AS runner
WORKDIR /app

# passed by docker build command
ENV version $VERSION
COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json ./package.json
COPY src/ ./

# passed by docker build command
#ENV version $VERSION   does not work
#ARG VERSION

CMD ["node", "./index.js"]
