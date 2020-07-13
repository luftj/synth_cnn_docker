docker run --name cnn_synth_test -ti --rm \
    --gpus device=1 \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model/:/app/cnn_lstm_ctc_ocr/data/model/ \
    --entrypoint python \
    cnn_synth \
    test.py