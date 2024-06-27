# start with the latest Ubuntu image
FROM ubuntu:latest

# add user enea and set password, delete default user ubuntu
RUN useradd -m enea && \
    echo "enea:password" | chpasswd && \
    userdel -r ubuntu

# install required packages, remove bash-completion, 
# install mysql-server in a non-interactive way, clean up
RUN apt-get update && \
    apt-get --purge remove bash-completion && \
    apt-get install -y mysql-server && \
    apt-get clean

# set data directory for mysql
RUN usermod -d /var/lib/mysql/ mysql

# start mysql service, wait for it to start,
# execute mysql_secure_installation script in a non-interactive way,
# create databases and tables, insert arbitrary data, stop mysql service
RUN service mysql start && sleep 5 && \
    mysql -prootpassword -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'rootpassword';" && \
    mysql -prootpassword -e "DELETE FROM mysql.user WHERE User='';" && \
    mysql -prootpassword -e "DROP DATABASE IF EXISTS test;" && \
    mysql -prootpassword -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" && \
    mysql -prootpassword -e "CREATE USER 'enea'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -prootpassword -e "GRANT ALL PRIVILEGES ON *.* TO 'enea'@'localhost';" && \
    mysql -prootpassword -e "FLUSH PRIVILEGES;" && \
    mysql -prootpassword -e "CREATE DATABASE IF NOT EXISTS Company;" && \
    mysql -prootpassword -e "USE Company; \
    CREATE TABLE IF NOT EXISTS Employees ( \
        employee_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Projects ( \
        project_id INT AUTO_INCREMENT PRIMARY KEY, \
        project_name VARCHAR(255) NOT NULL, \
        start_date DATE NOT NULL, \
        end_date DATE \
    ); \
    CREATE TABLE IF NOT EXISTS Customers ( \
        customer_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_name VARCHAR(255) NOT NULL, \
        contact_name VARCHAR(255), \
        email VARCHAR(255), \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Orders ( \
        order_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_id INT, \
        order_date DATE NOT NULL, \
        total DECIMAL(15, 2) NOT NULL, \
        status VARCHAR(50), \
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Products ( \
        product_id INT AUTO_INCREMENT PRIMARY KEY, \
        product_name VARCHAR(255) NOT NULL, \
        product_price DECIMAL(10, 2) NOT NULL, \
        stock INT NOT NULL \
    );" && \
    mysql -prootpassword -e "CREATE DATABASE IF NOT EXISTS University;" && \
    mysql -prootpassword -e "USE University; \
    CREATE TABLE IF NOT EXISTS Students ( \
        student_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Courses ( \
        course_id INT AUTO_INCREMENT PRIMARY KEY, \
        course_name VARCHAR(255) NOT NULL, \
        start_date DATE NOT NULL, \
        end_date DATE \
    ); \
    CREATE TABLE IF NOT EXISTS Professors ( \
        professor_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Enrollments ( \
        enrollment_id INT AUTO_INCREMENT PRIMARY KEY, \
        student_id INT, \
        course_id INT, \
        enroll_date DATE, \
        FOREIGN KEY (student_id) REFERENCES Students(student_id), \
        FOREIGN KEY (course_id) REFERENCES Courses(course_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Departments ( \
        department_id INT AUTO_INCREMENT PRIMARY KEY, \
        department_name VARCHAR(255) NOT NULL, \
        head_of_department VARCHAR(255) NOT NULL \
    );" && \
    mysql -prootpassword -e "CREATE DATABASE IF NOT EXISTS Hospital;" && \
    mysql -prootpassword -e "USE Hospital; \
    CREATE TABLE IF NOT EXISTS Patients ( \
        patient_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Doctors ( \
        doctor_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Appointments ( \
        appointment_id INT AUTO_INCREMENT PRIMARY KEY, \
        patient_id INT, \
        doctor_id INT, \
        appointment_date DATE NOT NULL, \
        appointment_time TIME NOT NULL, \
        FOREIGN KEY (patient_id) REFERENCES Patients(patient_id), \
        FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Medications ( \
        medication_id INT AUTO_INCREMENT PRIMARY KEY, \
        patient_id INT, \
        medication_name VARCHAR(255) NOT NULL, \
        dosage VARCHAR(255) NOT NULL, \
        start_date DATE NOT NULL, \
        end_date DATE, \
        FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Departments ( \
        department_id INT AUTO_INCREMENT PRIMARY KEY, \
        department_name VARCHAR(255) NOT NULL, \
        head_of_department VARCHAR(255) NOT NULL \
    );" && \
    mysql -prootpassword -e "CREATE DATABASE IF NOT EXISTS Bank;" && \
    mysql -prootpassword -e "USE Bank; \
    CREATE TABLE IF NOT EXISTS Accounts ( \
        account_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_id INT, \
        account_type VARCHAR(255) NOT NULL, \
        balance DECIMAL(15, 2) NOT NULL \
    ); \
    CREATE TABLE IF NOT EXISTS Transactions ( \
        transaction_id INT AUTO_INCREMENT PRIMARY KEY, \
        account_id INT, \
        transaction_date DATE NOT NULL, \
        amount DECIMAL(15, 2) NOT NULL, \
        transaction_type VARCHAR(255) NOT NULL, \
        FOREIGN KEY (account_id) REFERENCES Accounts(account_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Customers ( \
        customer_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_name VARCHAR(255) NOT NULL, \
        contact_name VARCHAR(255), \
        email VARCHAR(255), \
        phone_number VARCHAR(20) \
    ); \
    CREATE TABLE IF NOT EXISTS Loans ( \
        loan_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_id INT, \
        loan_amount DECIMAL(15, 2) NOT NULL, \
        start_date DATE NOT NULL, \
        end_date DATE NOT NULL, \
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) \
    ); \
    CREATE TABLE IF NOT EXISTS Employees ( \
        employee_id INT AUTO_INCREMENT PRIMARY KEY, \
        first_name VARCHAR(255) NOT NULL, \
        last_name VARCHAR(255) NOT NULL, \
        email VARCHAR(255) NOT NULL, \
        phone_number VARCHAR(20), \
        position VARCHAR(255) NOT NULL, \
        hire_date DATE NOT NULL \
    ); \
    CREATE TABLE IF NOT EXISTS CreditCards ( \
        card_id INT AUTO_INCREMENT PRIMARY KEY, \
        customer_id INT, \
        card_number VARCHAR(16) NOT NULL UNIQUE, \
        card_type VARCHAR(255) NOT NULL, \
        expiration_date DATE NOT NULL, \
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) \
    );" && \
    mysql -prootpassword -e "USE Company; \
    INSERT INTO Employees (first_name, last_name, email, phone_number) VALUES \
        ('John', 'Doe', 'john.doe@comp.com', '555-1234'), \
        ('Jane', 'Smith', 'jane.smith@comp.com', '555-5678'), \
        ('Alice', 'Johnson', 'alice.johnson@comp.com', '555-8765'), \
        ('Bob', 'Brown', 'bob.brown@comp.com', '555-4321'); \
    INSERT INTO Projects (project_name, start_date, end_date) VALUES \
        ('Website Redesign', '2023-01-15', '2023-06-30'), \
        ('Mobile App Launch', '2023-03-01', '2023-12-31'), \
        ('Cloud Migration', '2023-05-20', '2024-02-28'), \
        ('Security Upgrade', '2023-07-10', '2023-11-15'); \
    INSERT INTO Customers (customer_name, contact_name, email, phone_number) VALUES \
        ('Acme Corp', 'Sarah Connor', 'sarah.connor@acme.com', '555-9876'), \
        ('Globex Inc', 'Hank Scorpio', 'hank.scorpio@globex.com', '555-6543'), \
        ('Initech', 'Peter Gibbons', 'peter.gibbons@initech.com', '555-3210'), \
        ('Umbrella Corp', 'Alice Abernathy', 'alice.abernathy@umbrella.com', '555-7890'); \
    INSERT INTO Orders (customer_id, order_date, total, status) VALUES \
        (1, '2023-04-01', 1500.00, 'Shipped'), \
        (2, '2023-05-15', 2500.00, 'Processing'), \
        (3, '2023-06-20', 3500.00, 'Delivered'), \
        (4, '2023-07-05', 4500.00, 'Cancelled'); \
    INSERT INTO Products (product_name, product_price, stock) VALUES \
        ('Laptop', 1200.00, 50), \
        ('Smartphone', 800.00, 150), \
        ('Tablet', 600.00, 100), \
        ('Monitor', 300.00, 75);" && \
    mysql -prootpassword -e "USE University; \
    INSERT INTO Students (first_name, last_name, email, phone_number) VALUES \
        ('Emily', 'Davis', 'emily.davis@uni.edu', '555-1111'), \
        ('Michael', 'Brown', 'michael.brown@uni.edu', '555-2222'), \
        ('Jessica', 'Wilson', 'jessica.wilson@uni.edu', '555-3333'), \
        ('Daniel', 'Taylor', 'daniel.taylor@uni.edu', '555-4444'); \
    INSERT INTO Courses (course_name, start_date, end_date) VALUES \
        ('Computer Science 101', '2023-01-10', '2023-05-15'), \
        ('Mathematics 201', '2023-02-01', '2023-06-20'), \
        ('Physics 301', '2023-03-05', '2023-07-25'), \
        ('Chemistry 101', '2023-04-10', '2023-08-30'); \
    INSERT INTO Professors (first_name, last_name, email, phone_number) VALUES \
        ('Robert', 'Smith', 'robert.smith@uni.edu', '555-5555'), \
        ('Linda', 'Johnson', 'linda.johnson@uni.edu', '555-6666'), \
        ('William', 'Lee', 'william.lee@uni.edu', '555-7777'), \
        ('Patricia', 'Miller', 'patricia.miller@uni.edu', '555-8888'); \
    INSERT INTO Enrollments (student_id, course_id, enroll_date) VALUES \
        (1, 1, '2023-01-15'), \
        (2, 2, '2023-02-05'), \
        (3, 3, '2023-03-10'), \
        (4, 4, '2023-04-15'); \
    INSERT INTO Departments (department_name, head_of_department) VALUES \
        ('Computer Science', 'Dr. Alan Turing'), \
        ('Mathematics', 'Dr. Ada Lovelace'), \
        ('Physics', 'Dr. Albert Einstein'), \
        ('Chemistry', 'Dr. Marie Curie');" && \
    mysql -prootpassword -e "USE Hospital; \
    INSERT INTO Patients (first_name, last_name, email, phone_number) VALUES \
        ('James', 'Anderson', 'james.anderson@hos.com', '555-1010'), \
        ('Mary', 'Thompson', 'mary.thompson@hos.com', '555-2020'), \
        ('Patricia', 'Martinez', 'patricia.martinez@hos.com', '555-3030'), \
        ('Michael', 'Garcia', 'michael.garcia@hos.com', '555-4040'); \
    INSERT INTO Doctors (first_name, last_name, email, phone_number) VALUES \
        ('John', 'Smith', 'john.smith@hos.com', '555-5050'), \
        ('Linda', 'Johnson', 'linda.johnson@hos.com', '555-6060'), \
        ('Robert', 'Brown', 'robert.brown@hos.com', '555-7070'), \
        ('Susan', 'Davis', 'susan.davis@hos.com', '555-8080'); \
    INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time) VALUES \
        (1, 1, '2023-06-01', '09:00:00'), \
        (2, 2, '2023-06-02', '10:00:00'), \
        (3, 3, '2023-06-03', '11:00:00'), \
        (4, 4, '2023-06-04', '12:00:00'); \
    INSERT INTO Medications (patient_id, medication_name, dosage, start_date) VALUES \
        (1, 'Ibuprofen', '200mg', '2023-06-01'), \
        (2, 'Paracetamol', '500mg', '2023-06-02'), \
        (3, 'Amoxicillin', '250mg', '2023-06-03'), \
        (4, 'Metformin', '850mg', '2023-06-04'); \
    INSERT INTO Departments (department_name, head_of_department) VALUES \
        ('Cardiology', 'Dr. Gregory House'), \
        ('Neurology', 'Dr. Meredith Grey'), \
        ('Oncology', 'Dr. Richard Webber'), \
        ('Pediatrics', 'Dr. Miranda Bailey');" && \
    mysql -prootpassword -e "USE Bank; \
    INSERT INTO Accounts (customer_id, account_type, balance) VALUES \
        (1, 'Savings', 5000.00), \
        (2, 'Checking', 1500.00), \
        (3, 'Savings', 3000.00), \
        (4, 'Checking', 2500.00); \
    INSERT INTO Transactions (account_id, transaction_date, amount, transaction_type) VALUES \
        (1, '2023-05-01', 1000.00, 'Deposit'), \
        (2, '2023-05-02', 500.00, 'Withdrawal'), \
        (3, '2023-05-03', 1500.00, 'Deposit'), \
        (4, '2023-05-04', 200.00, 'Withdrawal'); \
    INSERT INTO Customers (customer_name, contact_name, email, phone_number) VALUES \
        ('John Doe', 'John Doe', 'john.doe@bank.com', '555-1111'), \
        ('Jane Smith', 'Jane Smith', 'jane.smith@bank.com', '555-2222'), \
        ('Alice Johnson', 'Alice Johnson', 'alice.johnson@bank.com', '555-3333'), \
        ('Bob Brown', 'Bob Brown', 'bob.brown@bank.com', '555-4444'); \
    INSERT INTO Loans (customer_id, loan_amount, start_date, end_date) VALUES \
        (1, 10000.00, '2023-01-01', '2024-01-01'), \
        (2, 20000.00, '2023-02-01', '2024-02-01'), \
        (3, 15000.00, '2023-03-01', '2024-03-01'), \
        (4, 25000.00, '2023-04-01', '2024-04-01'); \
    INSERT INTO Employees (first_name, last_name, email, phone_number, position, hire_date) VALUES \
        ('Emma', 'Wilson', 'emma.wilson@bank.com', '555-5555', 'Manager', '2022-01-01'), \
        ('Liam', 'Martinez', 'liam.martinez@bank.com', '555-6666', 'Clerk', '2022-02-01'), \
        ('Olivia', 'Anderson', 'olivia.anderson@bank.com', '555-7777', 'Teller', '2022-03-01'), \
        ('Noah', 'Thompson', 'noah.thompson@bank.com', '555-8888', 'Loan Officer', '2022-04-01'); \
    INSERT INTO CreditCards (customer_id, card_number, card_type, expiration_date) VALUES \
        (1, '4000123412341234', 'Visa', '2025-12-31'), \
        (2, '5100123412341234', 'MasterCard', '2024-11-30'), \
        (3, '370012341234123', 'American Express', '2026-10-31'), \
        (4, '6011123412341234', 'Discover', '2025-09-30');" && \
    service mysql stop

# set up mysql configuration
RUN sed -i 's/^# pid-file/pid-file/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# socket/socket/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# port/port/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# datadir/datadir/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# general_log_file/general_log_file/' /etc/mysql/mysql.conf.d/mysqld.cnf && \
    sed -i 's/^# general_log/general_log/' /etc/mysql/mysql.conf.d/mysqld.cnf

# set up permissions for mysql directories
RUN chmod go+rx /var/lib/mysql/ && \
    chmod go+rx /var/run/mysqld/ && \
    chmod 777 /var/log/mysql

# create directories for enea user copying content from local content/ directory
COPY ./content/Projects /home/enea/Projects
COPY ./content/Reports /home/enea/Reports
COPY ./content/Scripts /home/enea/Scripts
COPY ./content/Documents /home/enea/Documents

# set up permissions for enea user directories
RUN chown -R enea:enea /home/enea/Projects && \
    chown -R enea:enea /home/enea/Reports && \
    chown -R enea:enea /home/enea/Scripts && \
    chown -R enea:enea /home/enea/Documents

# disable completion for enea user
RUN echo "set disable-completion on" >> /home/enea/.inputrc

# switch to enea user
USER enea

# set working directory for enea user
WORKDIR /home/enea