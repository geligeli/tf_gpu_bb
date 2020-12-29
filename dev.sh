#!/bin/bash

mkdir -p /home/geli/{tf_gpu_dev_out,tf_gpu_dev_src}

cd development_image
make deploy

docker pull 192.168.0.14:5000/tf-gpu-env:latest
docker run \
  -it --rm \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -v /home/geli/.bazel_in_docker:/home/geli/.bazel_in_docker \
  -v /home/geli/tf_gpu_dev_out:/mnt \
  -v /home/geli/tf_gpu_dev_src:/home/geli/tf_gpu_dev_src \
  192.168.0.14:5000/tf-gpu-env \
  bash
