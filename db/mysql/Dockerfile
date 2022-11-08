FROM guranchik/debian:0.2
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN mkdir /var/run/mysqld && \
    chown -R mysql /var/run/mysqld
COPY  --chown=mysql:mysql conf/my.cnf /etc/mysql/my.cnf
RUN apt -y update && apt -y install \
    mariadb-server 
EXPOSE 3306
CMD ["mariadbd"]