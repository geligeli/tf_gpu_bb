FROM tensorflow/tensorflow:devel-gpu
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
