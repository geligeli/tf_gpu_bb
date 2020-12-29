#!/bin/bash

docker run \
  -it --rm \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -v /home/geli:/home/geli \
  192.168.0.14:5000/tf-gpu-env \
  bash
