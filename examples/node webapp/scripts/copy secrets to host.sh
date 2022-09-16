#!/bin/bash
# must be run from parent folder



secrets="{
    \"db_connection\": \"aaa\"
}"

echo secrets

function pause(){
 read -s -n 1 -p "Press any key to continue . . ."
 echo ""
}

## Pause it ##
pause