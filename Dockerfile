FROM ubuntu:latest

# Create a new user
RUN useradd -m enea && echo "enea:password" | chpasswd

# Install MySQL server
RUN apt-get update && \
    apt-get install -y mysql-server && \
    apt-get clean

# Expose MySQL port
EXPOSE 3306

# Switch to root to perform secure installation
USER root

# Run MySQL secure installation and create user
RUN service mysql start && \
    /usr/bin/mysqladmin -u root password 'newpassword' && \
    mysql -uroot -pnewpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -uroot -pnewpassword -e "DROP DATABASE test;" && \
    mysql -uroot -pnewpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -uroot -pnewpassword -e "FLUSH PRIVILEGES;" && \
    mysql -uroot -pnewpassword -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root';" && \
    mysql -uroot -pnewpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -uroot -pnewpassword -e "DROP USER IF EXISTS ''@'localhost';" && \
    mysql -uroot -pnewpassword -e "DROP USER IF EXISTS ''@'$(hostname)';" && \
    mysql -uroot -pnewpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -uroot -pnewpassword -e "FLUSH PRIVILEGES;" && \
    mysql -uroot -pnewpassword -e "CREATE USER 'enea'@'%' IDENTIFIED BY 'password';" && \
    mysql -uroot -pnewpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'%' WITH GRANT OPTION;" && \
    mysql -uroot -pnewpassword -e "FLUSH PRIVILEGES;" && \
    service mysql stop

# Switch to the new user
USER enea

# Set the working directory
WORKDIR /home/enea

# Start MySQL server
CMD ["mysqld"]