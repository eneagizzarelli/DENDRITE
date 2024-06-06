FROM ubuntu:latest

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

# Delete the default 'ubuntu' user if it exists
RUN userdel -r ubuntu || true

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea