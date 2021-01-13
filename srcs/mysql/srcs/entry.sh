#!/bin/bash
/etc/init.d/mariadb setup
rc-service mariadb start
mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY 'password'; FLUSH PRIVILEGES;"
mysql -e "GRANT SELECT, INSERT, UPDATE, DELETE ON phpmyadmin.* TO 'pma'@'%' IDENTIFIED BY 'pmapass'; flush privileges;"
mysql -e "CREATE DATABASE wordpress_db; GRANT ALL ON wordpress_db.* TO 'wp_user'@'%' IDENTIFIED BY 'wp_pass'; flush privileges;"
mysql < /srcs/create_tables.sql -u root
mysql < /srcs/wordpress_db.sql -u root
rc-service mariadb restart
cd /etc/telegraf/usr/bin
./telegraf &
while true; do
echo -n
done
