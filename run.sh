#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

source $DIR/env.sh

NAME=cntlm

docker network create proxy 2>/dev/null

docker container stop $NAME >/dev/null
docker container rm $NAME >/dev/null
docker container run --name $NAME \
  --restart always \
  --network=proxy \
  -p $CNTLM_LISTEN_IP:3128:3128 \
  -e USERNAME=$CNTLM_USERNAME \
  -e DOMAIN=$CNTLM_DOMAIN \
  -e PASSNTLMV2=$CNTLM_PASSNTLMV2 \
  -e PROXY=$CNTLM_PROXY \
  -e OPTIONS="-w $CNTLM_WORKSTATION" \
  -d \
  $NAME:latest
