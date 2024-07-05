#! /usr/bin/env bash

chmod +x "$AWSBPM"/webserver/bin/*.sh

exec "$AWSBPM"/bin/httpd-startup.sh
