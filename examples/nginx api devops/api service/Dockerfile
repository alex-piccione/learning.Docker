FROM node:19-alpine AS dependencies
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --omit=dev --frozen-lockfile

FROM node:19-alpine AS runner
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY package.json ./package.json
COPY src/ ./

# passed by docker build command (ARG is required, why?)
ARG VERSION
ENV version $VERSION

CMD ["node", "./index.js"]
