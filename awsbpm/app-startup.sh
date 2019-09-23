#! /usr/bin/env bash

# wait for database ready
while true
do
    if timeout 5 bash -c "cat </dev/null >/dev/tcp/127.0.0.1/3306"; then
        echo "database ready"
        break
    else
        sleep 5
    fi
done

# awsbpm init
if [[ ! -f $AWSBPM/apps/app-platform.xml ]]; then
    echo "initializing awsbpm"
    if tar -C $AWSBPM -xf $AWSBPM/apps.tar.gz && \
    tar -C $AWSBPM -xf $AWSBPM/doccenter.tar.gz && \
    echo "CREATE DATABASE AWSBPM CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;" | mysql -u root && \
    echo "CREATE USER 'AWSBPM'@'%' IDENTIFIED BY 'AWSBPM';" | mysql -u root && \
    echo "GRANT ALL ON *.* TO 'AWSBPM'@'%';" | mysql -u root && \
    mysql -u root -D AWSBPM < $AWSBPM/db_script/mysql.sql; then
        echo "initialize awsbpm done"
    else
        echo "initialize awsbpm failed"
    fi
fi

exec $AWSBPM/bin/aws_startup.sh