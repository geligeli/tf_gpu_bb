FROM tensorflow/tensorflow:devel-gpu
COPY tf_configure.bazelrc /tensorflow_src/.tf_configure.bazelrc
ARG uid=1000
ARG user=geli
ARG gid=1000
ARG group=geli
RUN groupadd -g ${gid} ${group}
RUN useradd -ms /bin/bash ${user} -u ${uid} -g ${gid}
RUN echo 'bazel build --config=opt --config=cuda  //tensorflow/tools/pip_package:build_pip_package' >> /home/${user}/.bash_history
RUN chown -R ${uid}:${gid} /tensorflow_src
USER ${user}
COPY --chown=${user}:${group} .bazelrc /home/${user}/.bazelrc
RUN ln -s /home/${user}/.bazel_in_docker /home/${user}/.cache
WORKDIR /tensorflow_src
