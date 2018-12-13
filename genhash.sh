#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DIR/env.sh

echo "Type password:"
docker run -it cntlm:latest \
	/usr/sbin/cntlm -f -I -H \
	-u $CNTLM_USERNAME \
	-d $CNTLM_DOMAIN
