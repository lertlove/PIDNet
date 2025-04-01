#!/bin/bash
cd "${0%/*}"
xhost +local:root

source ./arg.sh

if [ "$(uname)" == "Darwin" ]
then
    export HOST_IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
    xhost +$HOST_IP
    export DISPLAY=$HOST_IP":0"
fi

docker rm -f pid-net

docker-compose rm -f

docker-compose build pid-net

docker-compose up -d pid-net