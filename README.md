## Installation

install docker.

` ./install.sh ` builds the dockerfile with default params.

` ./install.sh gpu ` for CUDA accelerated system.

### for GPU acceleration:

needs docker 19.03! (https://phoenixnap.com/kb/how-to-install-docker-on-ubuntu-18-04)

` apt-get install docker docker-ce docker-ce-cli `

install nvidia-container-toolkit (https://github.com/NVIDIA/nvidia-docker)

## Usage

` ./run.sh `

run a test:

` ./run_test.sh `

To recognise some words, but the images in ./images/ and their filepaths in ./images/imagelist.txt.
They need to have either one or three channels and be exactly 32 pixels high.

` ./validate.sh `