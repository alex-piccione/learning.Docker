# Nginx on Docker automatd

Procedure, scripts and commands to execute Continuous Delivery using containers on a single Docker instance.  
We try to deploy a web app with a Nginx that makes a load balancer for the 2 instances.

## First setup

SSH authentication within Public Key must be in place.

```bash
$user = "alex"
$server_ip = "192.168.1.8"

```

Server should have a user to execute the operations.  
Create a "devops" user.

```PowerShell
$server_ip = "192.168.1.8"
$user = Read-Host "Enter username"
ssh $user@$server_ip



```

Server should have this scripts and files:

- Secrets file for the web app: _/root/secrets/wep-api.secrets.json_

```PowerShell
$server_ip=192.168.1.8
$user=devops
ssh
```

## Automated
