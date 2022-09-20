echo "Setting up Mongo DB"
LOG_FILE=/tmp/mongoDB.log


curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>> /tmp/mongoDB.log
echo "Status $?"
yum install -y mongodb-org &>> /tmp/mongoDB.log
echo "Status $?"
systemctl enable mongod &>> /tmp/mongoDB.log
systemctl start mongod &>> /tmp/mongoDB.log
echo "Status $?"
sed -e -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf # Need to verify if the script doesn't work

systemctl restart mongod &>> /tmp/mongoDB.log
echo "Status $?"
sudo curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
sudo cd /tmp
sudo unzip mongodb.zip
sudo cd mongodb-main
mongod<catalogue.js
mongod<users.js
echo "Status $?"
