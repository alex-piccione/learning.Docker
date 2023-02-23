# Docker Swarm
<small>← [Readme](Readme.md)</small>

The Pluralsigh course of Nigel Poulton just jump from a description to a screen that seems to manage Docker swarm without any explanation.  
He says you can use local Docker app as fine as Docker Play.  

Running ``swarm init`` will set my current machine as a manager.  
I don't have other machines to set as managers or workers.  
No explanation to how do that!!


``docker service create --name test-web -p 8080:3000 --replicas 3 alessandropiccione/test-webapp:latest``

# Docker Stack
``docker stack deploy -c docker-compose.yml portfolio-web`` portfolio-web is the stack name

Ths create a service and deploy it to the swarm.

``docker stack ls``
``docker stack rm portfolio-web``
``docker stack ps portfolio-web``
``docker stack services portfolio-web``