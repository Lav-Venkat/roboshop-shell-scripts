echo "*****Setting up Mongo DB*****"
LOG_FILE=/tmp/mongoDB.log
source common.sh

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>> /tmp/mongoDB.log
StatusCheck $?
yum install -y mongodb-org &>> /tmp/mongoDB.log
StatusCheck $?
systemctl enable mongod
systemctl start mongod

sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf # Need to verify if the script doesn't work
echo "Status $?"
systemctl restart mongod
StatusCheck $?
echo"*****Download mongodb schema*****"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
echo "*****Extract schema*****"
cd /tmp
unzip mongodb.zip
cd mongodb-main
StatusCheck $?

echo "*****load catalogue service schema*****"
mongo < catalogue.js
mongo < users.js
StatusCheck $?
