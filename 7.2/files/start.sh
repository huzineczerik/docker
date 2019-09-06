#!/bin/bash

USER=`stat -c '%u' /project/`
GROUP=`stat -c '%g' /project/`

if [ "${USER}" != "0" ]; then
  echo "user = ${USER}" > /dev/shm/fpm-user.conf
  echo "group = ${GROUP}" >> /dev/shm/fpm-user.conf
else
  echo "user = www-data" > /dev/shm/fpm-user.conf
  echo "group = www-data" >> /dev/shm/fpm-user.conf
fi
echo "listen.mode = 0666" >> /dev/shm/fpm-user.conf

if [ -f /project/php.ini ]; then
  cp /project/php.ini /etc/php/7.2/cli/conf.d/user.ini
  cp /project/php.ini /etc/php/7.2/fpm/conf.d/user.ini
fi

/usr/sbin/php-fpm7.2 -F
