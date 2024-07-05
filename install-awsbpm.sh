#!/bin/bash

set -eux

_f='AWS_PaaS_Release_6.4.GA.45_Linux_64bit.tar.gz'
_d="${_f%.tar.gz}"

# install awsbpm
wget https://pub.hd.caiweiqiang.cn:5001/AWSBPM/${_f}
tar -xf ${_f}
rm -rf ${_f}
mv ${_d} AWSBPM
rm -rf AWSBPM/jdk1.8
ln -s /jdk1.8 AWSBPM/jdk1.8
tar -C AWSBPM -czf AWSBPM/apps.tar.gz apps
rm -rf AWSBPM/apps
mkdir -p AWSBPM/apps
tar -C AWSBPM -czf AWSBPM/doccenter.tar.gz doccenter
rm -rf AWSBPM/doccenter
mkdir -p AWSBPM/doccenter
