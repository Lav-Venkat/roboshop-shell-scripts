#!/usr/bin/bash
LOG_FILE=/tmp/frontend.log
echo "Installing Nginx"
yum install nginx -y

echo "downloading Nginx web content"
systemctl enable nginx &>> $LOG_FILE
systemctl start nginx &>> $LOG_FILE

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> $LOG_FILE


cd /usr/share/nginx/html

echo "removing unwanted files"

rm -rf * &>> $LOG_FILE

unzip /tmp/frontend.zip &>> $LOG_FILE
mv frontend-main/static/* .
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl restart nginx &>> $LOG_FILE