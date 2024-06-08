FROM ubuntu:latest

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

RUN apt-get update && apt-get install -y mysql-server

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea