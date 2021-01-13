#!/bin/sh

apk update
apk add nginx
apk add openrc
apk add bash
apk add openssl
apk add openssh
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www
openrc default
mv -f /srcs/nginx.conf /etc/nginx/
cp /srcs/index.html /www/
adduser sshuser -D
echo "sshuser:password" | chpasswd
rc-service sshd start
mkdir /etc/nginx/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key \
-out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=khouribga/L=Khouribga/O=leet/OU=ft_services/CN=ft_services"
wget -q https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
tar xf telegraf-1.17.0_linux_amd64.tar.gz
mv telegraf-1.17.0/ telegraf
mv telegraf /etc
cp /srcs/telegraf.conf /etc/telegraf
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /etc/telegraf/telegraf.conf"
bash -c "sed -i "s/EXTERNALHERE/$EXTERNALIP/g" /www/index.html"