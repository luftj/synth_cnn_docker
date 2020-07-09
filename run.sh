#!/bin/bash

docker stop cnn_synth_i
docker rm cnn_synth_i
# XAUTH=$HOME/.Xauthority
# touch $XAUTH
# DISPLAY=192.168.5.57:0.0
docker run --name cnn_synth_i -d cnn_synth -ti \
    --rm \
       --env DISPLAY=192.168.5.57:0.0 \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" 
docker logs -f cnn_synth_i