UPDATE mysql.user SET host = 'localhost' WHERE user = 'enea' AND host = '%';

DELETE FROM mysql.user WHERE user = 'root' AND host = '%';

FLUSH PRIVILEGES;