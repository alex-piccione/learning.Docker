# Radix Engine Simulator

Create an image for the Radix Engine Simulator that execute what is described here:
https://docs.radixdlt.com/main/scrypto/getting-started/install-scrypto.html.

> git clone https://github.com/radixdlt/radixdlt-scrypto.git
> cd radixdlt-scrypto
> cargo install --path ./simulator


## Create image

``docker image build -t alex-piccione/radix-engine-simulator:latest .``
``docker image build -t alex-piccione/radix-engine-simulator:0.1 . -f Dopckerfile.v2``

## Publish

``docker image push  alex-piccione/radix-engine-simulator:0.1``

rename image
``docker image tag alex-piccione/radix-engine-simulator:0.1 alessandropiccione/radix-engine-simulator:0.1``
``docker image push alessandropiccione/radix-engine-simulator:0.1``


run interactive container to test simulator
``docker container run --name rx-simulator alessandropiccione/radix-engine-simulator:0.1``
``docker container run -it --name rx-simulator alessandropiccione/radix-engine-simulator:0.1 /bin/bash``
``resim reset``  