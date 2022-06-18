# Docker Compose

``docker-compose build``
``docker-compose up``
``docker-compose down``
``docker-compose logs``
``docker-compose ps``
``docker-compose start``
``docker-compose stop``
``docker-compose rm``

``docker-compose`` itself within replicas does not manage the swarm, despite Docker App shows then in a subfolder called "swarm".  
For example all the containers are exposed to the same port so only the first one will be assigned to it and the other will raise an error.  

## docker-compose build
It builds or rebuild services defined in the docker-compose.yml.  

``docker-compose build <service>``

## docker-compose up
Create container and start them.

``docker-compose up <service>``
``docker-compose up --no-deps <service>`` = only that service
Use ``-d`` to run in non-interactive mode.  
Use ``logs`` to see the logs.  

## docker-compose down
Stop and remove the containers.

``docker-compose down --rmi all --volumes`` removes also the images (and their volumes)
