# Docker on a VPS
<small>← [Readme](Readme.md)</small>

Manage Docker on a remote server.  
Connect with SSH and execute commands from there.  

```sh
server=<IP>
username=root
```

Conenct with SSH: ``ssh username@server`` or ``ssh $username@$server``

## Steps to add Docker
1. Update the apt package index: ``sudo apt update``
2. Install packages to allow apt to use a repository over HTTPS: ``sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common``
3. Add the Docker official GPG key: 
   (Ubuntu 20.04) ``curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`` 
   (Ubuntu 22.04) ``sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0EBFCD88``
3b. (Ubuntu 20.04)  Verify that you now have the key with the fingerprint: ``sudo apt-key fingerprint 0EBFCD88``
5. Add the Docker repository to the apt sources list: ``sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"``
6. Update the apt package index again: ``sudo apt update``
7. Install the latest version of Docker Engine and containerd: ``sudo apt install docker-ce docker-ce-cli containerd.io``
8. Start the Docker daemon: ``sudo systemctl start docker``
9. Verify that Docker is installed and running correctly: ``sudo docker run hello-world``
10. Add your user to the docker group, so you can execute Docker commands without using "sudo": ``sudo usermod -aG docker $USER``

To check the Docker daemon is running:
``systemctl status docker`` or ``docker info``

### Check if API are exposed
You can check if the Docker daemon is publicly exposing the API by checking the configuration file located at /etc/docker/daemon.json.  
This file contains the configuration options for the Docker daemon, including the IP address and port on which it is listening.

