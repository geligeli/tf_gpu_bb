UID=$(shell id -u)
USER=$(shell id -u -n)
GID=$(shell id -g)
GROUP=$(shell id -g -n)
container:
	docker build \
	--build-arg uid=$(UID) \
	--build-arg user=$(USER) \
	--build-arg gid=$(GID) \
	--build-arg group=$(GROUP) \
	. --tag 192.168.0.13:5000/tf-gpu-beta

deploy: container
	docker push 192.168.0.13:5000/tf-gpu-beta

