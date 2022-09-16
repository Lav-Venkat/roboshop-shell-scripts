#!/usr/bin/bash
echo "Installing Nginx"
yum install nginx -y

echo "downloading Nginx web content"
systemctl enable nginx
systemctl start nginx

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> /tmp/frontend.log


cd /usr/share/nginx/html

echo "removing unwanted files"

rm -rf * &>> /tmp/frontend.log

unzip /tmp/frontend.zip &>> /tmp/frontend.log
mv frontend-main/static/* .
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx &>> /tmp/frontend.log