if [ "$#" = 0 ];
then
    echo "please supply a input path as argument"
    exit
fi

inputpath=$1
groundtruthpath=$2
./resize.sh $inputpath

docker run --name cnn_synth_val -ti --rm \
    -v "$(pwd)"/cnn_lstm_ctc_ocr/data/model:/app/cnn_lstm_ctc_ocr/data/model \
    -v "$(pwd)"/$inputpath:/app/images/ \
    --entrypoint bash \
    cnn_synth \
    /app/pyval.sh > validate_log.txt 2>/dev/null


python3 eval.py "$(cat validate_log.txt | tail -n 1)" $groundtruthpath --ignorecase