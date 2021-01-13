
#!/bin/sh

apk update
apk add nginx
apk add openrc
apk add bash
apk add php-session php-mbstring php7-common php7-iconv php7-json php7-gd php7-curl php7-zlib php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
apk add php-mysqli php7 php7-fpm php7-opcache
apk add php-fpm
openrc default
adduser -D -g 'www' www
mkdir /www
mkdir /etc/nginx/ssl
chown -R www:www /var/lib/nginx
chown -R www:www /www
chown -R www:www /var/www/localhost/htdocs/
wget -q https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz -C /var/www/localhost/htdocs/
mv -f /srcs/nginx.conf /etc/nginx/
cp /srcs/wp-config.php /var/www/localhost/htdocs/wordpress/
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /var/www/localhost/htdocs/wordpress/wp-config.php"
wget -q https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
tar xf telegraf-1.17.0_linux_amd64.tar.gz
mv telegraf-1.17.0/ telegraf
mv telegraf /etc
cp /srcs/telegraf.conf /etc/telegraf
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /etc/telegraf/telegraf.conf"