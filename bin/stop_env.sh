#!/bin/bash

if [ -f .bazel_docker_id ]; then
  if [ ! -z $( docker ps -f id=$(cat .bazel_docker_id) -q ) ]; then
    echo "bazel contianer already running as $(cat .bazel_docker_id) shutting it down"
    docker stop $(cat .bazel_docker_id)
    rm .bazel_docker_id
    exit 0
  fi
fi

