# Docker-compose

``docker-compose`` itself within replicas does not manage the swarm, despite Docker App shows then in a subfolder called "swarm".    
For example all the containers are exposed to the same port so only the first one will be assigned to it and the other will raise an error. Container turning down are not replaced automatically.  
