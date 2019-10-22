FROM centos:7

# set timezone to Shanghai
RUN \
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# install supervisor
RUN \
yum install -y epel-release && \
yum install -y supervisor && \
yum clean all && \
rm -rf /var/cache/yum
# install mysql
RUN \
yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm && \
yum-config-manager --disable mysql80-community && \
yum-config-manager --enable mysql57-community && \
yum install -y mysql-community-server mysql-community-client && \
yum clean all && \
rm -rf /var/cache/yum
# install awsbpm
## 安装glibc-common防止中文乱码
RUN \
yum install -y wget glibc-common && yum clean all && rm -rf /var/cache/yum && \
wget -q https://pub.caiweiqiang.cn/AWSBPM/AWS_PaaS_Release_6.2.GA_Linux_64bit.tar.gz && \
tar -xf AWS_PaaS_Release_6.2.GA_Linux_64bit.tar.gz && \
rm -rf AWS_PaaS_Release_6.2.GA_Linux_64bit.tar.gz && \
mv AWS_PaaS_Release_6.2.GA_Linux_64bit AWSBPM && \
tar -C AWSBPM -czf AWSBPM/apps.tar.gz apps && rm -rf AWSBPM/apps && mkdir -p AWSBPM/apps && \
tar -C AWSBPM -czf AWSBPM/doccenter.tar.gz doccenter && rm -rf AWSBPM/doccenter && mkdir -p AWSBPM/doccenter

# supervisor configuration
COPY supervisor/supervisord.conf /etc/
COPY supervisor/supervisord-startup.sh /usr/local/bin/
# mysql configuration
COPY mysql/mysql-startup.sh /usr/local/bin/
COPY mysql/my.cnf /etc/
ENV DB_AUTO_START=true USE_EXTERNAL_DATABASE=false
VOLUME /var/lib/mysql
EXPOSE 3306/tcp
# awsbpm configuration
COPY awsbpm/app-startup.sh awsbpm/web-startup.sh /usr/local/bin/
COPY awsbpm/aws_startup.sh awsbpm/httpd-startup.sh /AWSBPM/bin/
COPY awsbpm/aws-portal.xml awsbpm/server.xml /AWSBPM/bin/conf/
ENV AWSBPM=/AWSBPM JAVA_HOME=/AWSBPM/jdk1.8
ENV APP_AUTO_START=true WEB_AUTO_START=true
## 防止中文乱码
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
VOLUME /AWSBPM/apps /AWSBPM/doccenter
EXPOSE 8088/tcp 8000/tcp


CMD /usr/local/bin/supervisord-startup.sh
