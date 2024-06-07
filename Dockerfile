FROM ubuntu/mysql:8.0-22.04_beta

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

COPY docker_entrypoint_scripts/sql_init.sql /docker-entrypoint-initdb.d/

RUN chmod 644 /docker-entrypoint-initdb.d/sql_init.sql

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea