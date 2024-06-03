# Dockerfile
FROM ubuntu:latest
RUN useradd -m enea && echo "enea:password" | chpasswd
USER enea
WORKDIR /home/enea