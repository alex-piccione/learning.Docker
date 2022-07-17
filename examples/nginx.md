# Nginx

<http://nginx.org>


Goal: setup a nginx container on a Linux server, passing command trought SSH, that can serve a simple service and expose it to public.
Use bash shell, not PowerShell, to simulate operation executed from a GitHub Action.  
Not really a matter because this setup has to be done once to prepare the environment.  

## 1.Run nginx docker container

``docker image pull nginx``  

Create and start a container wiuth Nginx image exposing port 80 to the world.  
``docker container run -d --name test.nginx --publish 80:80 nginx``

``curl http://<IP>:80``

## 2.Configure nginx container to serve a static HTML page

``mkdir -p /data/www``  -p creats intermediate directories
``echo "this is a test" > /data/www/index.html``
``docker container exec -it test.nginx bash``

Nginx is driven by its configuration file: nginx.conf.  
Documentation says it can be in onr of these places:

- /usr/local/nginx/conf
- /etc/nginx
- /usr/local/etc/nginx

Where the fuck is it?  
``find nginx.conf``
> find nginx.conf
Ok, that was a quick try...

``locate nginx.conf``
> bash: locate: command not found
This is weird...

``find -type f -name nginx.conf``
./etc/nginx/nginx.conf

ok. Read it:
``cat /etc/nginx/nginx.conf``
Saved it in /config/default-nginx.conf





## 2.Configure nginx container

``docker container exec -it test.nginx bash``