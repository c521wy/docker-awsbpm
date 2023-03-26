#! /usr/bin/env bash

# get into run script dir (resolve to absolute path)
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd) # This dir is where this script live.
cd "$SCRIPT_DIR" || exit 1

#JVM Home
# ---------------------
export JAVA_HOME="../jdk1.8/"
#export JAVA_HOME="../jdk1.7/"

#Current OS LANG
#export LANG=zh_CN.GBK

#Adding JvmOptions
# ---------------------
JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Dfile.encoding=utf-8 -Dsun.jnu.encoding=utf-8 -Duser.timezone=GMT+8 -Duser.language=zh -Duser.country=CN -Djava.net.preferIPv4Stack=true -Djava.util.logging.config.file=./lib/logging.properties -Djava.security.policy=./conf/java.policy -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=../logs "

# DEBUG
JAVA_DEBUG="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000"

# TEMP License
rm -rf ~/.fe285ab55cf5e

#JVM Version Options
# ---------------------
# 1.7 JAVA_OPTS="-server -Xmx2g -Xms2g -XX:PermSize=256m -XX:MaxPermSize=256m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled -XX:+UseCMSCompactAtFullCollection $JAVA_OPTS "
# 1.8 JAVA_OPTS="-server -Xmx2g -Xms2g -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled $JAVA_OPTS "
# 虚拟机监控参数:"-Dcom.sun.management.jmxremote.port=9393 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"

# Startup
# ---------------------
export JAVA_OPTS="-server -Xmx4g -Xms4g -XX:MetaspaceSize=1024m -XX:MaxMetaspaceSize=1024m -XX:SurvivorRatio=16 -XX:+UseParNewGC  -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:MaxTenuringThreshold=15 -XX:+ExplicitGCInvokesConcurrent -XX:+DoEscapeAnalysis -XX:+CMSClassUnloadingEnabled -Djava.awt.headless=true $JAVA_OPTS "
# shellcheck disable=SC2086
# shellcheck disable=SC2048
exec ${JAVA_HOME}/bin/java $JAVA_OPTS $JAVA_DEBUG $* -jar ./bootstrap.jar -r -lib "./patch;./lib;./jdbc" StartUp
