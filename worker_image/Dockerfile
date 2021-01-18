FROM tensorflow/tensorflow:devel-gpu
# RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
# RUN apt-get -y update
# RUN apt-get -y install gcc-10
# RUN apt-get -y install g++-10
# RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
# RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 20
# RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
# RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 20
# RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
# RUN update-alternatives --set cc /usr/bin/gcc
# RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
# RUN update-alternatives --set c++ /usr/bin/g++
# RUN apt-get -y install clang-10
# RUN apt-get -y install clang-format-10
WORKDIR /usr/local/bin
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.7.4/bazelisk-linux-amd64 -O bazelisk
RUN chmod a+x bazelisk
WORKDIR /root
RUN git clone https://github.com/bazelbuild/bazel-buildfarm.git
WORKDIR /root/bazel-buildfarm
# RUN git checkout tags/1.4.0
RUN bazelisk build //src/main/java/build/buildfarm:buildfarm-server_deploy.jar \
    //src/main/java/build/buildfarm:buildfarm-operationqueue-worker_deploy.jar \
    //src/main/java/build/buildfarm:buildfarm-shard-worker_deploy.jar
RUN mv bazel-bin/src/main/java/build/buildfarm/buildfarm-*deploy.jar .
RUN bazelisk clean
RUN rm -r /tensorflow_src /root/.cache
COPY config /config
EXPOSE 8980
EXPOSE 8981
