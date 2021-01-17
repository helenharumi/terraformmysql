#!/bin/bash
apt-get update 
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server-5.7 
mysql -u root -proot -e "CREATE DATABASE testeV" 
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root' IDENTIFIED BY 'root'" 
mysql -u root -proot -e "flush privileges" 
sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf 
service mysql restart