#! /usr/bin/env bash

set -uxe

# init apps doccenter
[[ ! -f $AWSBPM/apps/app-platform.xml ]] && \
    tar -C $AWSBPM -xf $AWSBPM/doccenter.tar.gz && \
    tar -C $AWSBPM -xf $AWSBPM/apps.tar.gz

# wait for database startup
until timeout 5 bash -c "cat </dev/null >/dev/tcp/127.0.0.1/3306" 2>/dev/null; do sleep 5; done

# init database
[[ ! -d /var/lib/mysql/AWSBPM ]] && \
    echo "CREATE DATABASE AWSBPM CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;" | mysql -u root && \
    echo "CREATE USER 'AWSBPM'@'%' IDENTIFIED BY 'AWSBPM';" | mysql -u root && \
    echo "GRANT ALL ON *.* TO 'AWSBPM'@'%';" | mysql -u root && \
    mysql -u root -D AWSBPM < $AWSBPM/db_script/mysql.sql


exec $AWSBPM/bin/aws_startup.sh