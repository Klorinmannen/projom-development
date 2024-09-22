#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <php_version>"
	exit 1
fi
PHP_VERSION=$1
PHP="php$PHP_VERSION"
PHP_EXTENSIONS="php$PHP_VERSION-dom php$PHP_VERSION-mysql php$PHP_VERSION-curl php$PHP_VERSION-mbstring php$PHP_VERSION-yaml php$PHP_VERSION-xml php$PHP_VERSION-xdebug"

echo -e "\n\n***Installing $PHP with extensions: $PHP_EXTENSIONS***\n\n"
sudo apt-get install -y $PHP $PHP_EXTENSIONS

sleep 1;

echo -e "***Installing Composer***\n\n"
sudo apt-get install -y composer
echo -e "Composer installed.\n\n"

exit 0
