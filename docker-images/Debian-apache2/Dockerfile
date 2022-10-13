FROM debian:11-slim
ENV TZ=Europe/Minsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 
RUN apt-get -y update && apt-get -y install \
      nano \
      net-tools \
      apache2
COPY ./html/* /var/www/html/
CMD [ "/usr/sbin/apache2ctl", "-DFOREGROUND" ]
EXPOSE 80
