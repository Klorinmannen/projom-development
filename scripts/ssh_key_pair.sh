#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <ssh_key_name> [ssh_key_comment = \"\"]"
	exit 0
fi
SSH_KEY_NAME="id_ed25519_projom_$1"

SSH_KEY_COMMENT=""
if [ -n "$2" ]; then
	SSH_KEY_COMMENT=$2
fi

echo -e "\n\n***Generating SSH key pair***\n"

echo -e "Starting ssh-agent\n\n" 
eval "$(ssh-agent -s)"
if [ $? -ne 0 ]; then
	echo "Error starting ssh-agent! .. exiting"
	exit 1
fi

mkdir -v ./.ssh

ssh-keygen -q -t ed25519 -f ./.ssh/$SSH_KEY_NAME -C "$SSH_KEY_COMMENT" -N ''
if [ $? -ne 0 ]; then
	echo "Error generating ssh key pair! .. exiting"
	exit 1
fi

ssh-add ./.ssh/$SSH_KEY_NAME
if [ $? -ne 0 ]; then
	echo "Error adding ssh key to ssh-agent! .. exiting"
	exit 1
fi

PUBLIC_KEY=$(cat ./.ssh/$SSH_KEY_NAME.pub)
echo -e "Public key: ./.ssh/$SSH_KEY_NAME.pub \n\n"
echo "Public key: $PUBLIC_KEY"
echo -e "\n\n"

echo -e "\n\n”SSH key pair generated successfully!\n\n"

exit 0
