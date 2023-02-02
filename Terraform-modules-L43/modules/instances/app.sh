#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h2><font color="gold">Build by Terraform</font></h2><br><p>
<font color="green">Privat IP: $myip<br><br>
<font color="magenta">
<b>Version 1.0<b>
</body>
</html>
EOF
sudo service httpd start
chkconfig httpd on