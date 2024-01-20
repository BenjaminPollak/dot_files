build:
	sudo docker build -t hello .
run: build
	sudo docker run -v /home/benjamin/dot_files:/mnt/cur --rm -it hello bash
