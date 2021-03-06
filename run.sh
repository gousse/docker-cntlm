#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

source $DIR/env.sh

NAME=cntlm
echo "Adding route to proxy"
sudo ip route add 10.171.108.33 via 10.0.2.2
echo "Adding route to dns"
sudo ip route add 10.114.0.1 via 10.0.2.2

docker network create proxy 2>/dev/null

docker container stop $NAME >/dev/null
docker container rm $NAME >/dev/null
docker container run --name $NAME \
  --restart always \
  --network host \
  -v $DIR/resolv.conf:/etc/resolv.conf \
  -e LISTEN="0.0.0.0:8080" \
  -e USERNAME=$CNTLM_USERNAME \
  -e DOMAIN=$CNTLM_DOMAIN \
  -e PASSNTLMV2=$CNTLM_PASSNTLMV2 \
  -e PROXY=$CNTLM_PROXY \
  -e OPTIONS="-w $CNTLM_WORKSTATION" \
  -d \
  $NAME:latest
