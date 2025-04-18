build:
	sudo docker build -t hello .
docker: build
	sudo docker run -v /home/benjamin/dot_files:/root/dot_files --rm -it hello bash
run-ubuntu:
	ansible-playbook --ask-become-pass desktop_config.yml --tags "ubuntu"
run-mac:
	ansible-playbook desktop_config.yml --tags "mac"
restow:
	zsh ubuntu.sh
