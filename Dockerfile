# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Create a new user 'enea' with a password 'password'
RUN useradd -m enea && echo "enea:password" | chpasswd

# Update the package list and install MySQL server
RUN apt-get update && apt-get install -y mysql-server && apt-get clean

# Adjust MySQL data directory ownership
RUN usermod -d /var/lib/mysql/ mysql

# Start MySQL server with --skip-grant-tables and run the necessary SQL commands
RUN service mysql start && sleep 5 && \
    mysql -prootpassword -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'rootpassword';" && \
    mysql -prootpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -prootpassword -e "DROP DATABASE IF EXISTS test;" && \
    mysql -prootpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -prootpassword -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost' WITH GRANT OPTION;" && \
    mysql -prootpassword -e "FLUSH PRIVILEGES;"

# Switch to the new user 'enea'
USER enea

# Set the working directory to the home directory of 'enea'
WORKDIR /home/enea

ENTRYPOINT service mysql start && /bin/bash