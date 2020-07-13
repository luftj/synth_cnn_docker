docker run --name cnn_synth_test -ti --rm \
    -p 8008:8008 \
    --gpus all \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model/:/app/cnn_lstm_ctc_ocr/data/model/ \
    --entrypoint python \
    cnn_synth \
    test.pygit a