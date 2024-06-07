FROM ubuntu/mysql:8.0-22.04_beta

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea