FROM ubuntu:latest

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

# Install MySQL server
RUN apt-get update && \
    apt-get install -y mysql-server && \
    sed -i 's/^bind-address\s*=.*$/bind-address = 127.0.0.1/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    service mysql start && \
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'rootpassword'; FLUSH PRIVILEGES;" && \
    mysql -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password'; GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;" && \
    service mysql stop

# Expose MySQL port
EXPOSE 3306

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea

# Start MySQL server
CMD ["mysqld"]