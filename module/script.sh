#!/bin/bash
yum update
yum install nginx -y
systemctl start nginx
systemctl enable nginx
echo "hello world $HOSTNAME" > /usr/share/nginx/html/index.html