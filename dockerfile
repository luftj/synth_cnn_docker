FROM ubuntu
RUN apt-get update && apt-get upgrade -y

# fix tzdata data enter request
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#RUN apt-get install -y build-essential
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y pkg-config
# V necessary?
#RUN apt-get install -y libpango-1.0-0 
RUN apt-get install -y libpango1.0-dev
RUN apt-get install -y libcairo2-dev
RUN apt-get install -y libopencv-dev
RUN apt-get install -y libboost-all-dev
# V necessary?
RUN apt-get install -y python-opencv

# X forwarding
RUN apt-get install -qqy x11-apps


# move files to dir
COPY . /app
WORKDIR /app/MapTextSynthesizer

# build synthesizer libs
#RUN cd /app/MapTextSynthesizer
RUN make python_ctypes

# can't pass this while running?!
ENV DISPLAY=192.168.5.57:0.0

#RUN pip install -r requirements.txt

ENTRYPOINT ["bash","/app/run_synth.sh"]
CMD []