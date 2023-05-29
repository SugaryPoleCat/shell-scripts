#!/bin/bash

# Get the log_file
log_file="$LOG_FOLDER/apt-packages.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# ugh

echo "Installing nginx" &>> $log_file
output=$(sudo apt install nginx -y &>> $log_file 2>&1)
error_check "Failed to install nginx. Output: $output"

log_message "Installing postgres"
output=$(sudo apt install postgresql -y &>> $log_file 2>&1)
error_check "Failed to install postgres. Output: $output"

log_message "Installing tmux"
output=$(sudo apt install tmux -y &>> $log_file 2>&1)
error_check "Failed to install tmux. Output: $output"

log_message "Installing snapd"
output=$(sudo apt install snapd -y &>> $log_file 2>&1)
error_check "Failed to install snap. Output: $output"

echo "Installing snap core" &>> $log_file
output=$(sudo snap install core &>> $log_file 2>&1)
error_check "Failed to install snap core. Output: $output"

echo "Refreshing snap core" &>> $log_file
output=$(sudo snap refresh core &>> $log_file 2>&1)
error_check "Failed to refresh snap core. Output: $output"

log_message "Installing certbot"
output=$(sudo snap install --classic certbot &>> $log_file 2>&1)
error_check "Failed to install certbot. Output: $output"

log_message "Installing node"
bash $SCRIPT_FOLDER/node-install.sh

log_message "Installing git... you should have it if you have this repo."
output=$(sudo apt install git -y &>> $log_file 2>&1)
error_check "Failed to install git. Output: $output"

log_message "Configuring git"
git config --global user.email "$GIT_USER_EMAIL"
git config --global user.name "$GIT_USER_NAME"

# Prepare certbot commands
cd $HOME/../../

sudo ln -s /snap/bin/certbot /usr/bin/certbot

cd $HOME
# here we should run the certbot stuff.

echo "Because I'm a little bit stupid, you must configure nginx yourself, cause I'm not sure how to do that using CLI yet." &>> $log_file
echo "After you configure your NGINX, run certbot with sudo certbot --nginx. Also have to be done manually." &>> $log_file