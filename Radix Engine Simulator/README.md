# Radix Engine Simulator

Create an image for the Radix Engine Simulator that execute what is described here:
<https://docs.radixdlt.com/main/scrypto/getting-started/install-scrypto.html>.

```bash
git clone <https://github.com/radixdlt/radixdlt-scrypto.git>  
cd radixdlt-scrypto
cargo install --path ./simulator
```

## Create the image

``docker image build -t alex-piccione/radix-engine-simulator:0.51 . -f "Radix Engine Simulator/Dockerfile.v3"``

docker image build -t alessandropiccione/cargo:dev . -f "Radix Engine Simulator/Dockerfile rust.v1"

docker container run -it --name cargo-test alessandropiccione/cargo:dev /bin/bash


``docker image tag alessandropiccione/cargo:dev alessandropiccione/cargo:0.1``  
``docker image push alessandropiccione/cargo:0.1``


## Test image locally

``docker container stop radix-engine-simulator``  
``docker container rm radix-engine-simulator -f``
``docker container run -it --name radix-engine-simulator alex-piccione/radix-engine-simulator:0.51 /bin/bash``


docker container run -it --name radix-engine-simulator-2 alessandropiccione/radix-engine-simulator:0.5 /bin/bash

try to tun:  
``cargo``
``ls /resim -af``

## Publish the image

rename image  
``docker image tag alex-piccione/radix-engine-simulator:0.51 alessandropiccione/radix-engine-simulator:0.51``  
``docker image push alessandropiccione/radix-engine-simulator:0.51``


## Use on GitHub

The local container works when I try it locally.  
It does not work when used in a GitHub Action.

image: alessandropiccione/radix-engine-simulator:0.51
Command I try: ``cargo``


docker pull alessandropiccione/radix-engine-simulator:0.51

docker container run -it --name radix-engine-simulator alessandropiccione/radix-engine-simulator:0.51