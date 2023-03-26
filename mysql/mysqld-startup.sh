#! /usr/bin/env bash

set -uxe

# init mysqld when first startup
if [[ ! -d /var/lib/mysql/mysql ]]; then
  /usr/sbin/mysqld --initialize-insecure --user=mysql --console
fi

exec /usr/sbin/mysqld --console
