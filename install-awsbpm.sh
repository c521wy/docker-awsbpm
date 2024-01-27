#!/bin/bash

# install awsbpm
wget https://pub.hd.caiweiqiang.cn:5001/AWSBPM/AWS_PaaS_Release_6.3.GA_Linux_64bit.tar.gz
tar -xf AWS_PaaS_Release_6.3.GA_Linux_64bit.tar.gz
rm -rf AWS_PaaS_Release_6.3.GA_Linux_64bit.tar.gz
mv AWS_PaaS_Release_6.3.GA_Linux_64bit AWSBPM
rm -rf AWSBPM/jdk1.8
ln -s /jdk1.8 AWSBPM/jdk1.8
tar -C AWSBPM -czf AWSBPM/apps.tar.gz apps
rm -rf AWSBPM/apps
mkdir -p AWSBPM/apps
tar -C AWSBPM -czf AWSBPM/doccenter.tar.gz doccenter
rm -rf AWSBPM/doccenter
mkdir -p AWSBPM/doccenter
