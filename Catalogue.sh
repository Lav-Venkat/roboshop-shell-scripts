echo "******Catalogue module set up*******"

set -x
LOG_FILE=/tmp/Catalogue.`date +%Y%m%d`.log

echo "********Install Node JS ************"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y &>> $LOG_FILE

echo "******* Set up the catalogue application **********"
useradd roboshop

echo "***** Download the catalogue application code*****"
cd /home/roboshop

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>> $LOG_FILE
cd /home/roboshop
unzip /tmp/catalogue.zip &>> $LOG_FILE
mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install &>> $LOG_FILE

echo "*****Set up the service with systemctl*****"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>> $LOG_FILE
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue

