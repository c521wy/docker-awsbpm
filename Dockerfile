FROM git.hd.caiweiqiang.cn:5001/docker-images/cache/rockylinux:9.1

COPY install.sh /

RUN /install.sh

COPY supervisor/supervisord.conf /etc/
COPY supervisor/supervisord-startup.sh /usr/local/bin/

COPY mysql/mysqld-startup.sh /usr/local/bin/
COPY mysql/my.cnf /etc/
ENV DB_AUTO_START=true USE_EXTERNAL_DATABASE=false
VOLUME /var/lib/mysql
EXPOSE 3306/tcp

COPY awsbpm/app-startup.sh awsbpm/web-startup.sh /usr/local/bin/
COPY awsbpm/aws_startup.sh awsbpm/httpd-startup.sh /AWSBPM/bin/
COPY awsbpm/aws-portal.xml awsbpm/server.xml /AWSBPM/bin/conf/
ENV AWSBPM=/AWSBPM JAVA_HOME=/AWSBPM/jdk1.8
ENV APP_AUTO_START=true WEB_AUTO_START=true
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
VOLUME /AWSBPM/apps /AWSBPM/doccenter
EXPOSE 8088/tcp 8000/tcp

CMD /usr/local/bin/supervisord-startup.sh
