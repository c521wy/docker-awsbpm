#!/bin/sh

export JAVA_HOME=../jdk1.8
export CATALINA_HOME=../webserver
export PATH=$PATH:../webserver/bin

exec "$CATALINA_HOME/bin/catalina.sh" run $*

