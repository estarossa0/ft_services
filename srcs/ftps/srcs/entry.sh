#!/bin/bash

rc-service vsftpd restart
cd /etc/telegraf/usr/bin
./telegraf &
while true; do
echo -n
done
