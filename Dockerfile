# Dockerfile
FROM ubuntu:latest

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

# Update the package list and install auditd
RUN apt-get update && apt-get install -y auditd

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea

# Ensure auditd starts with the container
CMD ["auditd", "-f"]