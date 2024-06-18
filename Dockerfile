# Use the latest version of Ubuntu as the base image
FROM ubuntu:latest

# Create a new user 'enea' with password 'password' and delete default user 'ubuntu'
RUN useradd -m enea && \
    echo "enea:password" | chpasswd && \
    userdel -r ubuntu

# Update the package list, install MySQL server and clean up the package list
RUN apt-get update && apt-get install -y mysql-server && apt-get clean

# Adjust MySQL data directory ownership and permissions
RUN usermod -d /var/lib/mysql/ mysql && \
    chmod go+rx /var/lib/mysql/ && \
    chmod go+rx /var/run/mysqld/

# Create a log file directory for the MySQL general log and set the correct ownership
RUN chmod 777 /var/log/mysql

# Start MySQL server and run the necessary SQL commands, logging to a file
RUN service mysql start && sleep 5 && \
    mysql -prootpassword -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'rootpassword';" && \
    mysql -prootpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -prootpassword -e "DROP DATABASE IF EXISTS test;" && \
    mysql -prootpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -prootpassword -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost' WITH GRANT OPTION;" && \
    mysql -prootpassword -e "FLUSH PRIVILEGES;" && \
    mysql -prootpassword -e "SET GLOBAL log_output = 'FILE';" && \
    mysql -prootpassword -e "SET GLOBAL general_log = 1;" && \
    mysql -prootpassword -e "SET GLOBAL general_log_file='/var/log/mysql/mysql_log.log';" && \
    service mysql stop

# Switch to the new user 'enea'
USER enea

# Set the working directory to the home directory of 'enea'
WORKDIR /home/enea