#!/bin/bash

docker run --name cnn_synth_i -ti -d --rm \
    --env DISPLAY=192.168.5.57:0.0 \
    -p 8008:8008 \
    -m 8g \
    cnn_synth \
    bash
    # --env-file env.list \
docker logs -f cnn_synth_i