FROM debian:0.1
RUN mkdir -p /etc/haproxy/ && \
    mkdir -p /run/haproxy/
RUN apt -y update && apt -y install \
      haproxy
COPY ./haproxy.cfg /etc/haproxy
#COPY ./ssl/tms.guranchik.com.pem /etc/ssl/private
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]