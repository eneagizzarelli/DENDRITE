# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Create a new user 'enea' with a password 'password'
RUN useradd -m enea && echo "enea:password" | chpasswd

# Update the package list and install MySQL server
RUN apt-get update && apt-get install -y mysql-server && apt-get clean

# Adjust MySQL data directory ownership
RUN usermod -d /var/lib/mysql/ mysql



# Switch to the new user 'enea'
USER enea

# Set the working directory to the home directory of 'enea'
WORKDIR /home/enea