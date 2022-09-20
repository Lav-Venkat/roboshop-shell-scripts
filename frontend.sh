#!/usr/bin/bash
LOG_FILE=/tmp/frontend.log

source common.sh

echo "Installing Nginx"
yum install nginx -y &>> $LOG_FILE
StatusCheck $?
echo "downloading Nginx web content"
# shellcheck disable=SC2129
systemctl enable nginx &>> $LOG_FILE
StatusCheck $?
systemctl start nginx &>> $LOG_FILE
StatusCheck $?

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>> $LOG_FILE
StatusCheck $?

cd /usr/share/nginx/html

echo "removing unwanted files"

rm -rf * &>> $LOG_FILE

unzip /tmp/frontend.zip &>> $LOG_FILE
StatusCheck $?
mv frontend-main/static/* .
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
StatusCheck $?
systemctl restart nginx &>> $LOG_FILE
StatusCheck $?