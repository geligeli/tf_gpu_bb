#!/bin/bash

pushd $PWD
cd $(dirname $0)/../development_image
make deploy
docker pull 192.168.0.14:5000/tf-gpu-env:latest
popd

if [ -f .bazel_docker_id ]; then
    if [ ! -z $( docker ps -f id=$(cat .bazel_docker_id) -q ) ]; then
        echo "bazel contianer already running as $(cat .bazel_docker_id) shutting it down"
        docker stop $(cat .bazel_docker_id)
        exit 0
    fi
fi

docker run \
  --rm -d -it \
  --name bazel-container \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -v /home/geli/.bazel_in_docker:/home/geli/.bazel_in_docker \
  -v $PWD:/src \
  192.168.0.14:5000/tf-gpu-env \
  bash > .bazel_docker_id

complete -o nospace -F _bazel__complete blaze