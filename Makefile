REMOTE_USERNAME ?= ubuntu
OUTPUT_FOLDER ?= ./run-outputs
APP :=

# mac os woulbd be xhyve, ubuntu virtualbox, kvm
VM := xhyve 

clean:
	find . -name *.retry -delete && rm -rf run-outputs/*

depend_ubuntu:
	sudo apt-get install -y ansible-2.3.0.0 tree git python-devel python-cffi openssl-devel

deploy: 
	ansible-playbook site.yml -v --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/deploy.`date +%F.%H.%s`.log

ping: 
	ansible all -m ping --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/ping.`date +%F.%H.%s`.log

bounce:
ifeq ($(APP),)
	ansible-playbook app.yml -v --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/bounce.`date +%F.%H.%s`.log 
else
	ansible-playbook app.yml -v --extra-vars "APP=${APP}.yml" --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/bounce.`date +%F.%H.%s`.log 
endif

start_minikube:
	minikube start --vm-driver=$(VM) && eval $(minikube docker-env)

stop_minikube:
	minikube stop

install_minikube:


.PHONY: clean deploy ping depend_ubuntu bounce 