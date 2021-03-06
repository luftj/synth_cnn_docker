FROM ubuntu:18.04
RUN apt-get update && apt-get upgrade -y

# fix tzdata data enter request from pkg-config
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# mapsynth deps
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y pkg-config
RUN apt-get install -y libpango1.0-dev
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y libopencv-dev
RUN apt-get install -y libboost-all-dev


# get da fonts
RUN apt-get install -y git
RUN apt-get install -y fonts-cantarell ttf-ubuntu-font-family
RUN git clone --depth 1 https://github.com/google/fonts.git /root/.fonts
RUN fc-cache -f

# install tensorflow for ocr cnn
RUN pip install tensorflow==1.14

# move files to dir
COPY ./MapTextSynthesizer /app/MapTextSynthesizer
WORKDIR /app/MapTextSynthesizer

# build synthesizer libs
RUN make python_ctypes

# # X forwarding
# RUN apt-get install -qqy x11-apps
# # run synth gui
# COPY run_synth.sh /app
# ENTRYPOINT ["bash","/app/run_synth.sh"]

# build generator
RUN make static
ENV PKG_CONFIG_PATH=/app/MapTextSynthesizer
WORKDIR /app/MapTextSynthesizer/tensorflow/generator/
RUN make lib

# envvars to find generator
ENV PYTHONPATH=$PYTHONPATH:/app/MapTextSynthesizer/tensorflow/generator/
ENV PATH=$PATH:/app/MapTextSynthesizer/tensorflow/generator/ipc_synth
ENV MTS_IPC=/app/MapTextSynthesizer/tensorflow/generator/ipc_synth
ENV OPENCV_OPENCL_RUNTIME=null
ENV OPENCV_OPENCL_DEVICE=disabled

# prepare ocr model code
COPY ./cnn_lstm_ctc_ocr /app/cnn_lstm_ctc_ocr

# COPY ./requirements.txt /app/requirements.txt
# RUN pip install -r /app/requirements.txt
RUN apt-get install -y python-opencv
RUN pip install pillow

# copy synth config
COPY ./fontlists /app/fontlists
COPY ./config.txt /app
COPY ./charset.py /app/cnn_lstm_ctc_ocr/src/charset.py

# start training ocr on synth data
WORKDIR /app/cnn_lstm_ctc_ocr/src
COPY ./run_cnn.sh /app
COPY ./pyval.sh /app
ENTRYPOINT [ "bash", "/app/run_cnn.sh" ]
# ENTRYPOINT ["python","train.py", "--nostatic_data", "--synth_config_file", "/app/config.txt"]
CMD []