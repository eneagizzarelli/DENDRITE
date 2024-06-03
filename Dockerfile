# Dockerfile
FROM ubuntu:latest
RUN useradd -m enea && echo "enea:password" | chpasswd
USER enea
WORKDIR /home/enea

# Install auditd in the container
RUN sudo apt-get install -y auditd
# Ensure auditd starts with the container
CMD ["auditd", "-f"]