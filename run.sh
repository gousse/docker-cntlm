#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

NAME=cntlm

docker container stop $NAME >/dev/null
docker container rm $NAME >/dev/null
docker container run --name $NAME \
  --restart always \
  -p 127.0.0.1:3128:3128 \
  -e USERNAME=$CNTLM_USERNAME \
  -e DOMAIN=$CNTLM_DOMAIN \
  -e PASSNTLMV2=$CNTLM_PASSNTLMV2 \
  -e PROXY=$CNTLM_PROXY \
  -d \
  $NAME:latest
