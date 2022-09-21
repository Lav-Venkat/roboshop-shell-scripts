#!/usr/bin/bash
LOG_FILE=/tmp/redis.`date +%y%m%d`.log

source common.sh
set -x

echo -e "\e[33mInstall Redis on CentOS-8\e[0m"

echo -e "\e[36mDownload redis package\e[0m"

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>> $LOG_FILE
StatusCheck $?
dnf module enable redis:remi-6.2 -y &>> $LOG_FILE
StatusCheck $?
yum install redis -y &>> $LOG_FILE
StatusCheck $?

echo -e "\e[33mUpdate the bind from \e[35m127.0.0.1\e[0m to \e[35m0.0.0.0\e[0m in config\e[0m"
sed -ie 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>> $LOG_FILE
StatusCheck $?
echo -e "\e[33mStart Redis Database\e[0m"
systemctl enable redis &>> $LOG_FILE
systemctl restart redis
StatusCheck $?