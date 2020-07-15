if [ "$#" = 0 ];
then
    echo "please supply a input path as argument"
    exit
fi

inputpath=$1
./resize.sh $inputpath

docker run --name cnn_synth_val -ti --rm \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model:/app/cnn_lstm_ctc_ocr/data/model \
    -v "$(pwd)"/$inputpath:/app/images/ \
    --entrypoint bash \
    cnn_synth \
    /app/pyval.sh