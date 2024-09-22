#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <domain> <system_dir>"
	exit 1
fi
DOMAIN=$1

if [ -z "$2" ]; then
	echo "Usage: $0 <domain> <system_dir>"
	exit 1
fi
SYSTEM_DIR=$2

echo -e "\n\n***Installing Apache 2***\n\n"
sudo apt-get update
sudo apt-get install -y apache2
sudo apt install -y net-tools

sleep 1

echo "Starting Apache2 service"
sudo systemctl start apache2

sleep 1

echo -e "\nEnabling headers .."
sudo a2enmod headers

echo -e "\nEnabling rewrite module .."
sudo a2enmod rewrite

echo -e "\nArchiving default vhost file .."
sudo mv -fv "/etc/apache2/sites-available/000-default.conf" "/etc/apache2/sites-available/default_old.conf"
if [ $? -ne 0 ]; then
	echo "Error archiving default vhost file"
	exit 1
fi

VHOST_FILE="000-$DOMAIN.conf"
IP=$(ifconfig | grep 'inet ' | awk '{print $2}' | head -n1):80

echo -e "\nCreating vhost file $VHOST_FILE for $DOMAIN with ip $IP"
sudo touch "/etc/apache2/sites-available/$VHOST_FILE"
if [ $? -ne 0 ]; then
	echo "Error creating empty vhost file: $VHOST_FILE"
	exit 1
fi

sudo DOMAIN=$DOMAIN SYSTEM_DIR=$SYSTEM_DIR IP=$IP bash -c "cat ../conf/vhost.conf | envsubst > /etc/apache2/sites-available/$VHOST_FILE"
if [ $? -ne 0 ]; then
	echo "Error creating vhost file: $VHOST_FILE"
	exit 1
fi

echo -e "\nEnabling virtual host .."
sudo a2ensite $VHOST_FILE

echo -e "\nRestarting Apache2 service .."
sudo systemctl restart apache2

exit 0
