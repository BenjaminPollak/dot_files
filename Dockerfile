FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install -y software-properties-common
RUN apt-add-repository -y ppa:ansible/ansible
RUN apt-add-repository -y ppa:neovim-ppa/unstable
RUN apt update
RUN apt install -y ansible 
