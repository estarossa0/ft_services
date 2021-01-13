#!/bin/sh

apk update
apk add openrc
apk add influxdb
apk add bash
openrc default
rc-service influxdb restart
wget -q https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
tar xf telegraf-1.17.0_linux_amd64.tar.gz
mv telegraf-1.17.0/ telegraf
mv telegraf /etc
cp /srcs/telegraf.conf /etc/telegraf
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /etc/telegraf/telegraf.conf"