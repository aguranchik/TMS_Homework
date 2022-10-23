FROM debian-apache2:0.2
RUN mkdir -p /opt/apache2/tms.guranchik.com/ && mkdir -p /opt/apache2/logs/
ADD ./apache2.conf /etc/apache2
ADD ./tms.guranchik.com.conf /etc/apache2/sites-available
RUN a2ensite tms.guranchik.com 
EXPOSE 80