# api-server NodeJs application

Simple Node app that responsd to:

- GET /  (HTML)
- GET /api/inso  (JSON)

## Docker image creation and publication

Crete a Docker image from a Dockerfile (run from wher is the Dockerfile)  
``docker image build -t alessandropiccione/test-api-server:2 .``

Test it:  
``docker container run -d --name test-api-server -p 8001:3000 alessandropiccione/test-api-server:2``
To remove the container: ``docker rm test-api-server -f``

Open <http:/localhost:8006> or <http:/localhost:8006/api/info> in a browser.  

Publish ``docker image push alessandropiccione/test-api-server:2``  
