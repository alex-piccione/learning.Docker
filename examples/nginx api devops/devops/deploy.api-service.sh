# /secrets is the container path linked to the Volume in the Dockerfile
#sed -i "s/$secretsFile:*^/secretsFile:\/secrets\/api-service.secrets.json,\n/" "api service/src/config.js"
#sed -i 's/aaa/bbb/' "api service/src/config.js"



## copy "/secrets/conf/api-service.secrets.json" to "/devop/conf/api-service/secrets.json"
## requires SSH comnnection opened

# curly brackets are used to escape the variable followed by colon (:)
scp "/d/secrets/api-service.secrets.json" $user@${server_ip}:/devop/conf/api-service/secrets.json