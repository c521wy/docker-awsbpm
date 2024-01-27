#!/bin/bash

set -eux

# set timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install supervisor
yum install -y epel-release
yum install -y supervisor

# install mysql
yum install -y yum-utils
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
yum install -y https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
yum install -y mysql-community-server mysql-community-client

# install jdk
yum install -y wget
arch=$(arch)
case $arch in
x86_64)
  wget https://pub.hd.caiweiqiang.cn:5001/amazon-corretto/amazon-corretto-8.362.08.1-linux-x64.tar.gz
  tar -xf amazon-corretto-8.362.08.1-linux-x64.tar.gz
  rm -rf amazon-corretto-8.362.08.1-linux-x64.tar.gz
  mv amazon-corretto-8.362.08.1-linux-x64 jdk1.8
  ;;
aarch64)
  wget https://pub.hd.caiweiqiang.cn:5001/amazon-corretto/amazon-corretto-8.362.08.1-linux-aarch64.tar.gz
  tar -xf amazon-corretto-8.362.08.1-linux-aarch64.tar.gz
  rm -rf amazon-corretto-8.362.08.1-linux-aarch64.tar.gz
  mv amazon-corretto-8.362.08.1-linux-aarch64 jdk1.8
  ;;
*)
  echo "unsupported platform [ $arch ]"
  exit 1
  ;;
esac

# install other tools
yum install -y glibc-common glibc-langpack-en glibc-langpack-zh

# cleanup
yum clean all
rm -rf /var/cache/yum
