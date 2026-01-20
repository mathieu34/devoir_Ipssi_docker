#!/bin/bash

if [ "$AUTOINDEX" = "on" ]; then
    echo "Autoindex ON"
    echo "<Directory /var/www/html>
    Options +Indexes
</Directory>" > /etc/apache2/conf-available/autoindex.conf
else
    echo "Autoindex OFF"
    echo "<Directory /var/www/html>
    Options -Indexes
</Directory>" > /etc/apache2/conf-available/autoindex.conf
fi

a2enconf autoindex


mysqld --user=mysql &
sleep 5

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'localhost' IDENTIFIED BY 'wppassword';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EOF


apachectl -D FOREGROUND
