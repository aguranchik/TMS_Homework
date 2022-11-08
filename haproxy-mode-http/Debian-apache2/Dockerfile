FROM guranchik/debian-apache2:0.2
RUN mkdir -p /opt/apache2/tms.guranchik.com/ \
    && mkdir -p /opt/apache2/logs/ \
    && mkdir -p /etc/apache2/ssl/
COPY ./apache2.conf /etc/apache2
COPY ./tms.guranchik.com.conf /etc/apache2/sites-available
RUN a2ensite tms.guranchik.com \
    && a2enmod ssl
RUN apt -y update && apt -y install \
      openssl
COPY ./ssl/* /etc/apache2/ssl/
EXPOSE 80
