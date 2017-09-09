REMOTE_USERNAME ?= ubuntu
OUTPUT_FOLDER ?= ./run-outputs

clean:
	find . -name *.retry -delete && rm -rf run-outputs/*

depend_ubuntu:
	sudo apt-get install -y ansible-2.3.0.0 tree git python-devel python-cffi openssl-devel

deploy: 
	ansible-playbook site.yml -v --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/deploy.`date +%F.%H.%s`.log

ping: 
	ansible all -m ping --user=$(REMOTE_USERNAME) 2>&1 | tee $(OUTPUT_FOLDER)/ping.`date +%F.%H.%s`.log

.PHONY: clean deploy ping depend_ubuntu