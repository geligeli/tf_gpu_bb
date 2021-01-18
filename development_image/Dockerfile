FROM tensorflow/tensorflow:devel-gpu
RUN add-apt-repository -y ppa:ubuntu-toolchain-r/test
RUN apt-get -y update
RUN apt-get -y install gcc-10
RUN apt-get -y install g++-10
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 10
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 20
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 20
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc 30
RUN update-alternatives --set cc /usr/bin/gcc
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
RUN update-alternatives --set c++ /usr/bin/g++
RUN apt-get -y install clang-10
RUN apt-get -y install clang-format-10
WORKDIR /usr/local/bin
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.7.4/bazelisk-linux-amd64 -O bazelisk
RUN chmod a+x bazelisk
RUN rm -rf /tensorflow_src /root/.cache
WORKDIR /root
RUN git clone https://github.com/bazelbuild/bazel-watcher.git
WORKDIR /root/bazel-watcher
RUN bazelisk build //ibazel
RUN cp /root/bazel-watcher/bazel-bin/ibazel/linux_amd64_stripped/ibazel /usr/local/bin
WORKDIR /
RUN rm -rf /root
RUN mkdir root
ARG uid=1000
ARG user=geli
ARG gid=1000
ARG group=geli
RUN groupadd -g ${gid} ${group}
RUN useradd -ms /bin/bash ${user} -u ${uid} -g ${gid}
# RUN echo 'bazel build --config=opt --config=cuda  //tensorflow/tools/pip_package:build_pip_package' >> /home/${user}/.bash_history
# RUN chown -R ${uid}:${gid} /tensorflow_src
USER ${user}
# COPY --chown=${user}:${group} tf_configure.bazelrc /tensorflow_src/.tf_configure.bazelrc
COPY --chown=${user}:${group} .bazelrc /home/${user}/.bazelrc
RUN ln -s /home/${user}/.bazel_in_docker /home/${user}/.cache
WORKDIR /home/${user}
# WORKDIR /tensorflow_src
