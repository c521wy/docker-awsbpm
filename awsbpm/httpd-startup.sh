#! /usr/bin/env bash

export JAVA_HOME=../jdk1.8
export CATALINA_HOME=../webserver
export PATH=$PATH:../webserver/bin

# shellcheck disable=SC2086
# shellcheck disable=SC2048
exec "$CATALINA_HOME/bin/catalina.sh" run $*
