#!/bin/bash

echo "starting training"
python train.py --nostatic_data --synth_config_file /app/config.txt --noipc_synth #&
# echo "starting monitor"
# tensorboard --logdir=data/model --port=8008
# make test