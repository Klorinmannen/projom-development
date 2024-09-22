#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <system> <user> <db_username> <db_name> [php_version = 8.1]"
	exit 1
fi 
SYSTEM=$1

if [ -z "$2" ]; then
	echo "Usage: $0 <system> <user> <db_username> <db_name> [php_version = 8.1]"
	exit 1
fi
USER=$2

if [ -z "$3" ]; then
	echo "Usage: $0 <system> <user> <db_username> <db_name> [php_version = 8.1]"
	exit 1
fi
DB_USERNAME=$3

if [ -z "$4" ]; then
	echo "Usage: $0 <system> <user> <db_username> <db_name> [php_version = 8.1]"
	exit 1
fi
DB_NAME=$4

PHP_VERSION="8.1"
if [ -n "$5" ]; then
	PHP_VERSION=$5
fi

echo -e "\n\nSetting up environment\n"

sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install curl
sudo apt-get -y install wget

sleep 1

bash ./scripts/php.sh $PHP_VERSION

sleep 1

bash ./scripts/mariadb_install.sh $DB_USERNAME $DB_NAME
if [ $? -ne 0 ]; then
	echo "Error: MariaDB installation failed"
	exit 1
fi

sleep 1

bash ./scripts/ssh_key_pair.sh $SYSTEM $USER
if [ $? -ne 0 ]; then
	echo "Error: SSH key pair generation failed"
	exit 1
fi

exit 0
