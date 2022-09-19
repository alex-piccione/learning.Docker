# Node webapp

Try to run an app in a Docker container that can load info from the host.  



## Test the image

test-dockerfile.sh
```
echo docker build
docker image rm test-web-app:latest
docker build -t test-web-app:latest .

echo docker run
docker container rm test-server -f
docker run -d -p 3001:3000 --name test-server test-web-app:latest  
  
```


``cont_id=$(docker container ls -a --filter "name=test-server" | awk 'NR>1 {print $1}')``

``docker container ls -a name=test-server``

