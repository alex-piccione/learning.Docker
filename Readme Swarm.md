# Docker Swarm

The Pluralsigh course of Nigel Poulton just jump from a description to a screen that seems to manage Docker swarm without any explanation.  
He says you can use local Docker app as fine as Docker Play.  

Running ``swarm init`` will set my current machine as a manager.  
But I don't have othe rmachines to set as managers and workers.  
No explanation to how do that!!


``docker service create --name test-web -p 8080:3000 --replicas 3 alessandropiccione/test-webapp:latest``

# Docker Stack
``docker stack deploy -c docker-compose.yml potfolio-web``

Ths create a service and deploy it.  