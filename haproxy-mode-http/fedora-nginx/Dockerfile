FROM fedora-nginx:0.2
RUN mkdir -p /opt/nginx/tms.guranchik.com/ \
    && mkdir -p /opt/nginx/logs/\
    && mkdir -p /etc/nginx/ssl/
COPY ./nginx.conf /etc/nginx
RUN yum -y update && yum -y install \
      openssl
COPY ./ssl/* /etc/nginx/ssl/
EXPOSE 80