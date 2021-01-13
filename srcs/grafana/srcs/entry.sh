#!/bin/bash

cd /grafana/bin/
./grafana-server &
cd /etc/telegraf/usr/bin
./telegraf &
while true; do
echo -n
done