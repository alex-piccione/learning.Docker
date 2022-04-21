FROM redis:latest

LABEL maintainer=Alex

ENV APP_ENV development

COPY ./docker/config/redis.${APP_ENV}.conf /etc/redis.conf

EXPOSE 6379

ENTRYPOINT [ "redis-server", "/etc/redis.conf" ]

# To build:
# dodker build -f redis.dockerfile --tag redis-instance ../

# To run:
# docker run -d -p 6379:6379 --name redis redis-instance