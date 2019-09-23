#! /usr/bin/env bash

# mysqld init
if [[ ! -d /var/lib/mysql/mysql ]]; then
    echo "initializing mysqld"
    if /usr/sbin/mysqld --initialize-insecure --user=mysql --console; then
        echo "initialize mysqld done"
    else
        echo "initialize mysqld failed"
        exit 1
    fi
fi

# mysqld startup
exec /usr/sbin/mysqld --console