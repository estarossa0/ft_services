#!/bin/sh

apk update
apk add openrc
apk add wget -q
apk add bash
wget -q https://dl.grafana.com/oss/release/grafana-7.3.1.linux-amd64.tar.gz
tar -zxvf grafana-7.3.1.linux-amd64.tar.gz
mv grafana-7.3.1 /grafana
mkdir /grafana/ssl
cp /srcs/dashboards/* /grafana/conf/provisioning/dashboards
cp /srcs/datasource.yaml /grafana/conf/provisioning/datasources/
cp /srcs/dashboard.yaml /grafana/conf/provisioning/dashboards
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /grafana/conf/provisioning/datasources/datasource.yaml"
wget -q https://dl.influxdata.com/telegraf/releases/telegraf-1.17.0_linux_amd64.tar.gz
tar xf telegraf-1.17.0_linux_amd64.tar.gz
mv telegraf-1.17.0/ telegraf
mv telegraf /etc
cp /srcs/telegraf.conf /etc/telegraf
bash -c "sed -i "s/URLIPHERE/$KUBEIP/g" /etc/telegraf/telegraf.conf"
apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat