#!/bin/bash

docker stop cnn_synth_i
docker rm cnn_synth_i
# XAUTH=$HOME/.Xauthority
# touch $XAUTH
# DISPLAY=192.168.5.57:0.0
docker run --name cnn_synth_i  -ti --rm -d \
    --env DISPLAY=192.168.5.57:0.0 \
    cnn_synth
    # --env-file env.list \
docker logs -f cnn_synth_i