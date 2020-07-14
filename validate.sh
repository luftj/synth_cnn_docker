docker run --name cnn_synth_val -ti --rm \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model:/app/cnn_lstm_ctc_ocr/data/model \
    -v "$(pwd)"/images:/app/images/ \
    --entrypoint bash \
    cnn_synth \
    pyval.sh