#!/bin/bash

# Get the log_file
log_file="$LOG_FOLDER/apt-packages.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# ugh
log_message "Installing node"
bash $SCRIPT_FOLDER/node-install.sh

log_message "Installing git... you should have it if you have this repo."
sudo apt install git -y

log_message "Configuring git"
git config --global user.email "$GIT_USER_EMAIL"
git config --global user.name "$GIT_USER_NAME"

log_message "Installing postgres"
output=$(sudo apt install postgres -y &>> $log_file 2>&1)
error_check "Failed to install postgres. Output: $output"

log_message "Installing snap"
output=$(sudo apt install snap -y &>> $log_file 2>&1)
error_check "Failed to install snap. Output: $output"

log_message "Installing certbot"
output=$(sudo snap install certbot &>> $log_file 2>&1)
error_check "Failed to install certbot. Output: $output"