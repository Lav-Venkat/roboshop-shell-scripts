echo "******Catalogue module set up*******"
source common.sh
set -x

LOG_FILE=/tmp/Catalogue.`date +%Y%m%d`.log

echo "*****Setup node JS repos*****"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
StatusCheck $?
echo "********Install Node JS ************"
yum install nodejs -y &>> $LOG_FILE
StatusCheck $?
echo "******* Set up the catalogue application **********"

id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
  echo "Add Roboshop application user"
  useradd roboshop
  if [ $? -eq 0 ]; then
    echo "Status - Success"
  else
    echo "Status - Failure"
    exit 1
  fi
fi
StatusCheck $?
echo "***** Download the catalogue application code*****"
cd /home/roboshop
rm -rf catalogue*

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>> $LOG_FILE
StatusCheck $?
cd /home/roboshop
unzip /tmp/catalogue.zip &>> $LOG_FILE
mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install &>> $LOG_FILE
StatusCheck $?

echo "*****Set up the service with systemctl*****"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>> $LOG_FILE
StatusCheck $?
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue
StatusCheck $?
