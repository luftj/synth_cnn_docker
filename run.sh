#!/bin/bash

docker run --name cnn_synth_i -ti -d --rm \
    -p 8008:8008 \
    --gpus all \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model/:/app/cnn_lstm_ctc_ocr/data/model/ \
    cnn_synth \
    bash
    # --env-file env.list \
    #--env DISPLAY=192.168.5.57:0.0 \
docker logs -f cnn_synth_i
