build:
	sudo docker build -t hello .
docker: build
	sudo docker run -v /home/benjamin/dot_files:/root/dot_files --rm -it hello bash
run:
	ansible-playbook desktop_config.yml
