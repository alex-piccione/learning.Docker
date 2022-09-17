#!/bin/bash
# must be run from parent folder

host_secrets_path="D:/temp/secrets.json"

echo "### Copy secrets in host path"
echo "copy secrets file from \"$PWD\""
cp "$PWD/scripts/.secrets.json" $host_secrets_path
echo
echo


function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

## Pause it ##
#pause