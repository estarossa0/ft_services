#!/bin/bash
openrc default
rc-service nginx start
rc-service php-fpm7 start
cd /etc/telegraf/usr/bin
./telegraf &
while sleep 20; do
  pgrep nginx
  PROCESS_STATUS=$?
  if [ $PROCESS_STATUS -ne 0 ]; then
    rc-service nginx restart
  fi
done