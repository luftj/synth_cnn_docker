#!/bin/bash

if [ $1 == "gpu" ]; then
    docker build -t=cnn_synth -f dockerfile_gpu .
else
    docker build -t=cnn_synth .
fi