#! /usr/bin/env bash

set -uxe

# init apps and doccenter when first startup
if [[ ! -f $AWSBPM/apps/app-platform.xml ]]; then
  tar -C "$AWSBPM" -xf "$AWSBPM"/doccenter.tar.gz
  rm -f "$AWSBPM"/doccenter.tar.gz
  tar -C "$AWSBPM" -xf "$AWSBPM"/apps.tar.gz
  rm -f "$AWSBPM"/apps.tar.gz
fi

# when using internal databse
if [[ "$USE_EXTERNAL_DATABASE" = "false" ]]; then
  # wait for database startup
  until timeout 5 bash -c "cat </dev/null >/dev/tcp/127.0.0.1/3306" 2>/dev/null; do sleep 5; done
  # init database when first startup
  if [[ ! -d /var/lib/mysql/AWSBPM ]] && [[ ! -d /var/lib/mysql/awsbpm ]]; then
    echo "CREATE DATABASE AWSBPM CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;" | mysql -u root
    echo "CREATE USER 'AWSBPM'@'%' IDENTIFIED BY 'AWSBPM';" | mysql -u root
    echo "GRANT ALL ON *.* TO 'AWSBPM'@'%';" | mysql -u root
    mysql -u root -D AWSBPM <"$AWSBPM"/db_script/mysql.sql
  fi
fi

exec "$AWSBPM"/bin/aws_startup.sh
