FROM tensorflow/tensorflow:devel-gpu
RUN add-apt-repository -y ppa:linuxuprising/java
RUN apt-get update
RUN echo oracle-java15-installer shared/accepted-oracle-license-v1-2 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java15-set-default
RUN rm -rf /tensorflow_src /root/.cache
RUN apt-get install -y google-perftools
