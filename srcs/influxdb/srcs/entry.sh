#!/bin/bash

openrc default
rc-service influxdb start
sleep 3
influx -execute "CREATE USER \"admin\" WITH PASSWORD 'password' WITH ALL PRIVILEGES"
rc-service influxdb restart
cd /etc/telegraf/usr/bin
./telegraf &
while true; do
echo -n
done
