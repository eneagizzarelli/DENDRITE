FROM ubuntu:latest

RUN useradd -m enea && \
    echo "enea:password" | chpasswd && \
    userdel -r ubuntu

RUN apt-get update && \
    apt-get --purge remove bash-completion && \
    apt-get install -y mysql-server && \
    apt-get clean

RUN usermod -d /var/lib/mysql/ mysql

RUN service mysql start && sleep 5 && \
    mysql -prootpassword -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'rootpassword';" && \
    mysql -prootpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -prootpassword -e "DROP DATABASE IF EXISTS test;" && \
    mysql -prootpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -prootpassword -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost' WITH GRANT OPTION;" && \
    mysql -prootpassword -e "FLUSH PRIVILEGES;" && \
    service mysql stop

RUN sed -i 's/^# pid-file/pid-file/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# socket/socket/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# port/port/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# datadir/datadir/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# general_log_file/general_log_file/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# general_log/general_log/' /etc/mysql/mysql.conf.d/mysqld.cnf

RUN chmod go+rx /var/lib/mysql/ && \
    chmod go+rx /var/run/mysqld/ && \
    chmod 777 /var/log/mysql

RUN sed -i '/if ! shopt -oq posix; then/,/fi/ {s/^/#/; /^fi$/s/^#//; /^fi$/s/^/#/}' "/home/enea/.bashrc"

USER enea

WORKDIR /home/enea