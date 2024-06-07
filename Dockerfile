FROM ubuntu/mysql:8.0-22.04_beta

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

COPY docker_entrypoint_scripts/sql_init.sql /docker-entrypoint-initdb.d/
COPY docker_entrypoint_scripts/exe_init.sh /docker-entrypoint-initdb.d/
COPY docker_entrypoint_scripts/exe.sh /

RUN chown -R enea:enea /docker-entrypoint-initdb.d && \
chmod 777 /docker-entrypoint-initdb.d && \
chmod 777 /docker-entrypoint-initdb.d/sql_init.sql && \
chmod 777 /docker-entrypoint-initdb.d/exe_init.sh && \
chown enea:enea /exe.sh && \
chmod 777 /exe.sh

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea