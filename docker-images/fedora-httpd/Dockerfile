FROM fedora:36
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 
RUN yum -y update && yum -y install \
      nano \
      net-tools \
      httpd
COPY ./html/* /var/www/html/
CMD [ "/usr/sbin/httpd", "-DFOREGROUND" ]
EXPOSE 80