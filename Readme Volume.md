# Docker Volume
<small>← [Readme](Readme.md)</small>

https://docs.docker.com/storage/bind-mounts

Volume is a way to save permanent data when a container is deleted.  
It can be activated in different ways:
- docker run ``-v`` option
- docker run ``--mount`` option
- Dockerfile ``VOLUME`` command
- docker-compose

With Docker, the most common types of storage that is mounted into containers are the following three (taken from [here][1]):

**Volumes** are stored in a part of the host filesystem which is managed by Docker (`/var/lib/docker/volumes/` on Linux). Non-Docker processes should not modify this part of the filesystem. Volumes are the best way to persist data in Docker.

**Bind mounts** may be stored anywhere on the host system. They may even be important system files or directories. Non-Docker processes on the Docker host or a Docker container can modify them at any time.

**tmpfs mounts** are stored in the host system’s memory only, and are never written to the host system’s filesystem.

Example:  
```docker
docker run -p 8500:8500 \
    --mount type=bind,source=$(pwd)/models/mnist,target=/models/mnist \
    -e MODEL_NAME=mnist \
    -t tensorflow/serving
```

So with `--mount` you can setup relevant options for those storage types in a very convenient way: <br>
The `type` field can be one of the 3 types mentioned above. <br>
The `source` is the mount point location in the *host file system*
(For named volumes, this is the name of the volume, for anonymous volumes, this field is omitted).<br>
The `target` is the mount point location *inside the container*.

----------------

Please notice that you'll see many examples using the `-v` or `--volume` flags in `docker run`. This was the official way until Docker `17.06`.  

(IMHO, use the `--mount` option, it can save you some debugging time, for example it will throw an error if you're trying to mount a directory which doesn't exists, this as opposed to to `--volume` which will create it).

[1]: https://docs.docker.com/storage/#choose-the-right-type-of-mount


## Docker run options



## Example of MongoDB container that store data on the host

``docker run --name test-mongo mongo:latest``