FROM tensorflow/tensorflow:devel-gpu
COPY tf_configure.bazelrc /tensorflow_src/.tf_configure.bazelrc
COPY .bazelrc /root/.bazelrc
RUN ln -s /home/geli/.bazel_in_docker /root/.cache
WORKDIR /tensorflow_src
