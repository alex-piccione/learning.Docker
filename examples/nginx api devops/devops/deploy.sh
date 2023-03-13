# This file runs the deploy on production server

# new docker "compose" command, replacing the docker-compose
docker compose -f /devop/scripts/api-service/compose.yml up --force-recreate -d