USE mysql;
UPDATE user SET host = 'localhost' WHERE user = 'enea' AND host = '%';
UPDATE user SET host = 'localhost' WHERE user = 'root' AND host = '%';
FLUSH PRIVILEGES;