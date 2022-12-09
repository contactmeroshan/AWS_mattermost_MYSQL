#!/bin/bash
sudo apt update -y
sudo apt install mysql-server -y
echo "Installed MySQL"
echo "Configuring MySQL now"


sudo mysql -u root <<-EOF
UPDATE mysql.user SET authentication_string=PASSWORD('password') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
FLUSH PRIVILEGES;
CREATE USER 'mmuser'@'%' IDENTIFIED BY 'mostest';
CREATE DATABASE mattermost_test;
GRANT ALL PRIVILEGES ON mattermost_test.* TO 'mmuser'@'%'; 
EOF

echo "MySQL Congiguration complete"
sudo sed "s/bind-address/#bind-address/" /etc/mysql/mysql.conf.d/mysqld.cnf > mysqld.cnf
sudo mv mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf 

sudo /etc/init.d/mysql restart
