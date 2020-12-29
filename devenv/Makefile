container:
	docker build . --tag 192.168.0.14:5000/tf-gpu-env

deploy: container
	docker push 192.168.0.14:5000/tf-gpu-env