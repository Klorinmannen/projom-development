#/!bin/bash

if [ -z "$1" ]; then
	echo -e "Usage: $0 <system_dir>"
	exit 1
fi
SYSTEM_DIR=$1

if [ -d "$SYSTEM_DIR" ]; then
	echo -e "Directory: $SYSTEM_DIR already exists. Do you want to replace it? (y/n)"
	read -e -p REPLACE_SYSTEM_DIR
	if [[ "$REPLACE_SYSTEM_DIR" != [Yy]* ]]; then
		echo -e "Exiting .."
		exit 0
	fi

	echo -e "\nMoving $SYSTEM_DIR to ${SYSTEM_DIR}_old"
	sudo mv -fv "/var/www/$SYSTEM_DIR" "/var/www/${SYSTEM_DIR}_old"
	if [ $? -ne 0 ]; then
		echo -e "\nError moving $SYSTEM_DIR to ${SYSTEM_DIR}_old .. exiting"
		exit 1
	fi

	sleep 1
fi

echo -e "\n\nCreating $SYSTEM_DIR directory!\n\n"

sudo mkdir -pv "/var/www/$SYSTEM_DIR"
if [ $? -ne 0 ]; then
	echo "Error creating $SYSTEM_DIR directory"
	exit 1
fi
sudo chown -Rv www-data:www-data $SYSTEM_DIR
sudo chmod -Rv 774 $SYSTEM_DIR

sudo mkdir -pv "/var/www/$SYSTEM_DIR/public"
if [ $? -ne 0 ]; then
	echo "Error creating $SYSTEM_DIR/public directory"
	exit 1
fi
sudo chown -Rv www-data:www-data "/var/www/$SYSTEM_DIR/public"
sudo chmod -Rv 774 "/var/www/$SYSTEM_DIR/public"

sudo mkdir -pv "/var/www/$SYSTEM_DIR/log"
if [ $? -ne 0 ]; then
	echo "Error creating $SYSTEM_DIR/log directory"
	exit 1
fi
sudo chown -Rv www-data:www-data "/var/www/$SYSTEM_DIR/log"
sudo chmod -Rv 774 "/var/www/$SYSTEM_DIR/log"

sudo mkdir -pv "/var/www/$SYSTEM_DIR/config"
if [ $? -ne 0 ]; then
	echo "Error creating $SYSTEM_DIR/config directory"
	exit 1
fi
sudo chown -Rv www-data:www-data "/var/www/$SYSTEM_DIR/config"
sudo chmod -Rv 774 "/var/www/$SYSTEM_DIR/config"

sudo mkdir -pv "/var/www/$SYSTEM_DIR/src"
if [ $? -ne 0 ]; then
	echo "Error creating $SYSTEM_DIR/src directory"
	exit 1
fi
sudo chown -Rv www-data:www-data "/var/www/$SYSTEM_DIR/src"
sudo chmod -Rv 774 "/var/www/$SYSTEM_DIR/src"

sleep 1

exit 0
