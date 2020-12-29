ssh geli@192.168.0.14 bash << 'EOF'
docker stop $(docker ps -a | grep -v registry | sed '1 d' | awk '{print $1}')
docker rm $(docker ps -a | grep -v registry | sed '1 d' | awk '{print $1}')
EOF

ssh geli@192.168.0.15 bash << 'EOF'
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
EOF

ssh geli@192.168.0.10 bash << 'EOF'
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
EOF

ssh geli@192.168.0.11 bash << 'EOF'
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
EOF

wait