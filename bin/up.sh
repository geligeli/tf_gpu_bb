#!/bin/bash

ssh geli@192.168.0.14 bash << 'EOF'
docker run -d --name buildfarm-redis -p 6379:6379 redis:5.0.9
docker pull 192.168.0.14:5000/tf-gpu-builder:latest
docker run -d \
  --name buildfarm-server \
  --add-host buildfarm-server:192.168.0.14 \
  -p 8980:8980 \
  192.168.0.14:5000/tf-gpu-builder \
  java -Djava.util.logging.config.file=/config/prod.logging.properties -jar buildfarm-server_deploy.jar /config/shard-server.config --port=8980 --public_name=192.168.0.14:8980
docker run \
  -d \
  --name buildfarm-worker \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -p 8981:8981 \
  -v /tmp/worker:/tmp/worker \
  192.168.0.14:5000/tf-gpu-builder \
  java -Djava.util.logging.config.file=/config/prod.logging.properties -jar buildfarm-shard-worker_deploy.jar /config/shard-worker-16.config --public_name=192.168.0.14:8981
EOF

ssh geli@192.168.0.15 bash << 'EOF'
docker pull 192.168.0.14:5000/tf-gpu-builder:latest
docker run -d \
  --name buildfarm-worker \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -p 8981:8981 \
  -v /tmp/worker:/tmp/worker \
  192.168.0.14:5000/tf-gpu-builder \
  java -Djava.util.logging.config.file=/config/prod.logging.properties -jar buildfarm-shard-worker_deploy.jar /config/shard-worker-16.config --public_name=192.168.0.15:8981
EOF

ssh geli@192.168.0.10 bash << 'EOF'
docker pull 192.168.0.14:5000/tf-gpu-builder:latest
docker run -d \
  --name buildfarm-worker \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -p 8981:8981 \
  -v /tmp/worker:/tmp/worker \
  192.168.0.14:5000/tf-gpu-builder \
  java -Djava.util.logging.config.file=/config/prod.logging.properties -jar buildfarm-shard-worker_deploy.jar /config/shard-worker-16.config --public_name=192.168.0.10:8981
EOF

ssh geli@192.168.0.11 bash << 'EOF'
docker pull 192.168.0.14:5000/tf-gpu-builder:latest
docker run -d \
  --name buildfarm-worker \
  --add-host buildfarm-server:192.168.0.14 \
  --add-host buildfarm-redis:192.168.0.14 \
  -p 8981:8981 \
  -v /tmp/worker:/tmp/worker \
  192.168.0.14:5000/tf-gpu-builder \
  java -Djava.util.logging.config.file=/config/prod.logging.properties -jar buildfarm-shard-worker_deploy.jar /config/shard-worker-16.config --public_name=192.168.0.11:8981
EOF
