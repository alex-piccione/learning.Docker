# MongoDB

This example shows how to run MongoDB on a container and store the database on the host.

See mongo container documentation...


## Volume
Prepare the Volume.  
``docker volume create --label mmm mongo-data``


## Bind mount

Create the database directory on local host machine.
``mkdir -p D:/test/mongo-data``