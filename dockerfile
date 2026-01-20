FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV AUTOINDEX=on
WORKDIR /

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
 && rm -rf /var/lib/apt/lists/*



RUN echo "deb [trusted=yes] http://repo.mysql.com/apt/debian buster mysql-8.0" \
 > /etc/apt/sources.list.d/mysql.list


RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    mysql-server \
 && rm -rf /var/lib/apt/lists/*

RUN rm -f /var/www/html/index.html

RUN wget https://wordpress.org/latest.tar.gz \
 && tar -xzf latest.tar.gz \
 && mv wordpress /var/www/html/wordpress \
 && rm latest.tar.gz

RUN chown -R www-data:www-data /var/www/html/wordpress \
 && chmod -R 755 /var/www/html/wordpress


RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
 && tar -xzf phpMyAdmin-latest-all-languages.tar.gz \
 && mv phpMyAdmin-*-all-languages /var/www/html/phpmyadmin \
 && rm phpMyAdmin-latest-all-languages.tar.gz

RUN chown -R www-data:www-data /var/www/html/phpmyadmin \
 && chmod -R 755 /var/www/html/phpmyadmin


RUN cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php \
 && sed -i "s/\$cfg\['blowfish_secret'\] = '';/\$cfg['blowfish_secret'] = 'ipssi_secret_123456';/" \
 /var/www/html/phpmyadmin/config.inc.php

RUN echo "<VirtualHost *:80>\n\
    DocumentRoot /var/www/html\n\
    <Directory /var/www/html>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>\n\
</VirtualHost>" > /etc/apache2/sites-available/000-default.conf


RUN a2enmod rewrite \
 && echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
