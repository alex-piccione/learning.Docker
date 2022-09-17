# Nginx on Docker

<http://nginx.org>

## Goal

Setup a Nginx container on a Linux server, passing commands trought SSH.  
Nginx instance is a load balancer for a simple web app also running on the same server.  
Nginx exposes itself over SSL.  
The webapp load the secrets from a file on the server.

Use bash shell, not PowerShell, to simulate operations executed from a GitHub Action.  
Not really a matter because this setup has to be done once to prepare the environment.

## Steps:

### 1. Create a Docker network

A Docker network is required to allow Nginx to communicate with the other containers.

`docker network disconnect network-test test-api` # disconnet container test-api  
`docker network disconnect network-test test-nginx` # disconnet container test-nginx  
`docker network rm test-network`  
`docker network create --driver bridge --subnet=172.20.0.0/16 test-network`  
`docker network list`  
`docker network inspect test-network`

### 2. Run the web app containers

`docker container rm test-api-1 -f`  
`docker container rm test-api-2 -f`

Run a simple server (and expose on port 81 for tests)  
`docker run -d --name test-api-1 --net=test-network --ip=172.20.0.10 alessandropiccione/test-api-service:latest`  
`docker run -d --name test-api-2 --net=test-network --ip=172.20.0.11 alessandropiccione/test-api-service:latest`  
`docker run -d -p 82:3005 --name test-api-2 --net=test-network --ip=172.20.0.11 alessandropiccione/test-api-service:2.1`  
`-p 81:port` is not mandatory, but it is useful to test it locally.  
`docker container list -a`

Test it: `curl http://localhost:81`

### 2.1 Set the secrets on services

(from local/deploy machine)
`scp secrets/secrets.prod.json alex@192.168.1.8:~/secrets.json`  
`scp "./examples/api service/secrets/secrets.prod.json" alex@192.168.1.8:~/secrets.json`

(from server machine)
`docker cp secrets.json test-api-1:/app/secrets.json`  
`docker container restart test-api-1 -t 3`  
`docker cp secrets.json test-api-2:/app/secrets.json`  
`docker container restart test-api-2 -t 3`

_/root/secrets/test-secrets_

create a local _test-secrets_ file and copy it with  
`cat /root/secrets/test-secrets | sed 's/<secret>/<secret>/g' > /config/default-nginx.conf`

### 3. Run Nginx container

`docker container rm test-nginx -f`

Create and start a container with Nginx image exposing port 80 to the world.  
`docker container run -d --name test-nginx --publish 80:80 --net=test-network nginx`

``curl http://$ip:80``

### 4. Configure Nginx container to serve a static HTML page (optional)

`mkdir -p /data/www` -p creates intermediate directories
`echo "this is a test" > /data/www/index.html`
`docker container exec -it test-nginx bash`

Nginx is driven by its configuration file: _nginx.conf_.  
Documentation says it can be in one of these places:

- /usr/local/nginx/conf
- /etc/nginx
- /usr/local/etc/nginx

Where the fuck is it?  
`find nginx.conf`

> find nginx.conf
> Ok, that was a quick try...

`locate nginx.conf`

> bash: locate: command not found
> This is weird...

`find -type f -name nginx.conf`
./etc/nginx/nginx.conf

ok. Read it:
`cat /etc/nginx/nginx.conf`
Saved it in /config/default-nginx.conf

Today, on a local linux machine `find -type f -name nginx.conf` does not return nothng.  
Ok, create the /etc/nginx/nginx.conf file:
`mkdir -p /etc/nginx`
`touch /etc/nginx/nginx.conf`

I had to use "sudo" and the file got the permission for root but not current user.  
`sudo edit /etc/nginx/nginx.conf`

### 5. Configure Nginx container as proxy

https://serverfault.com/questions/171678/nginx-config-front-end-reverse-proxy-to-another-port  
https://linuxhandbook.com/nginx-reverse-proxy-docker/

(run from local/deploy machine)
Copy local*nginx.config* to server:
`scp config/nginx.conf alex@192.168.1.8:~/nginx.conf` or  
`scp "./examples/nginx/config/nginx.conf" alex@192.168.1.8:~/nginx.conf` or  
`scp config/nginx.conf alex@192.168.1.8:/usr/nginx/nginx.conf`  
If you get _Permissione denied_ error, copy the file to the server as root:  
`sudo scp ...` or to a position where the user can write and then move it.

(from the server machine)
Copy the file into the Nginx container :
`docker cp ~/nginx.conf test-nginx:/etc/nginx/nginx.conf` or  
`docker cp /usr/nginx/nginx.conf test-nginx:/etc/nginx/nginx.conf`  
`rm ~/nginx.conf`

Restart nginx
`docker exec -it test-nginx nginx -s reload`

Check Nginx status:
???
