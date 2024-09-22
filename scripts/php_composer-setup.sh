#!/bin/bash

echo -e "\n\n***Installing Composer***\n\n"

echo "Checking for wget .."
sudo apt-get install -y wget

sleep 1

echo "Checking composer signatures .."
EXPECTED_SIGNATURE="$(wget -qO - https://composer.github.io/installer.sig)" &&
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" &&
ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    echo 'Signatures did not match .. exiting'
    sudo rm -fv composer-setup.php; exit 0
fi

echo "Installing composer .."
php composer-setup.php;

sleep 1

echo "Finalizing .."
sudo mv -fv composer.phar /usr/local/bin/composer &&
sudo chmod -v +x /usr/local/bin/composer &&
sudo rm -fv composer-setup.php

echo  "Composer installed."

exit 0