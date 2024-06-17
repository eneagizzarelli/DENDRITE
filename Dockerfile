# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Create a new user 'enea' with a password 'password'
RUN useradd -m enea && echo "enea:password" | chpasswd

# Update the package list and install MySQL server
RUN apt-get update && apt-get install -y mysql-server && apt-get clean

RUN usermod -d /var/lib/mysql/ mysql

RUN mysqld_safe --skip-grant-tables && sleep 10

# Start the MySQL service and secure the installation
RUN mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'rootpassword';" && \
    mysql -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -e "DROP DATABASE IF EXISTS test;" && \
    mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost' WITH GRANT OPTION;" && \
    mysql -e "FLUSH PRIVILEGES;"

# Switch to the new user 'enea'
USER enea

# Set the working directory to the home directory of 'enea'
WORKDIR /home/enea