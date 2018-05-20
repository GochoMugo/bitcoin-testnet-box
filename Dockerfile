# bitcoin-testnet-box docker image

# Ubuntu 14.04 LTS (Trusty Tahr)
FROM ubuntu:14.04
MAINTAINER Sean Lavine <lavis88@gmail.com>

# add bitcoind from the official PPA
# phase 1 (make `add-apt-repository` available):
RUN apt-get update
RUN apt-get install --yes software-properties-common
# phase 2 (add PPAs -> update cache -> install pkgs):
RUN add-apt-repository --yes ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install --yes \
    bitcoind \
    make \
    supervisor

# create a non-root user
RUN adduser --disabled-login --gecos "" tester && \
    mkdir /home/tester/bitcoin-testnet-box

# run commands from inside the testnet-box directory
WORKDIR /home/tester/bitcoin-testnet-box

# expose two rpc ports for the nodes to allow outside container access
EXPOSE 19001 19011

# describe how to start container
CMD ["/usr/bin/supervisord"]

# copy the testnet-box files into the image
ADD . /home/tester/bitcoin-testnet-box

# make tester user own the bitcoin-testnet-box
RUN chown -R tester:tester /home/tester/bitcoin-testnet-box

# create volume for the nodes
# VOLUME /home/tester/bitcoin-testnet-box/nodes

# use the tester user when running the image
USER tester
