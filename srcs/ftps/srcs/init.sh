#!/bin/sh

apk update
apk add vsftpd
apk add openrc
apk add openssl
apk add bash
cp /srcs/vsftpd.conf /etc/vsftpd/
openrc default
adduser ftpuser -D
echo "ftpuser:password" | chpasswd
rc-service vsftpd restart
mkdir /etc/vsftpd/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/vsftpd/ssl/vsftpd.key \
-out /etc/vsftpd/ssl/vsftpd.crt -subj "/C=MA/ST=khouribga/L=Khouribga/O=leet/OU=ft_services/CN=ft_services"
wget -q https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
tar xf telegraf-1.17.0_linux_amd64.tar.gz
mv telegraf-1.17.0/ telegraf
mv telegraf /etc
cp /srcs/telegraf.conf /etc/telegraf
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /etc/telegraf/telegraf.conf"