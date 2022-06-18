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

``docker ``