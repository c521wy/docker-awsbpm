#! /usr/bin/env bash

set -uxe

# init mysqld
[[ ! -d /var/lib/mysql/mysql ]] && \
    /usr/sbin/mysqld --initialize-insecure --user=mysql --console


exec /usr/sbin/mysqld --console