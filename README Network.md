# Network


``docker network create --driver bridge network_1``
``docker network ls``
``docker network insptect network_1``

"bridge" is a common driver but also cross host is possible

``docker run -d --net=network_1 --name my-mongo mongo