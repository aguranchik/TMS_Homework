#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
cat <<EOF > /etc/nginx/conf.d/apache.conf
server {
    listen 80 default_server;
    server_name  _;
    root         /usr/share/nginx/html;


    location / {
        proxy_pass http://app;
        index  index.html index.htm;
    }
}
EOF
sudo systemctl enable nginx
sudo systemctl start nginx
