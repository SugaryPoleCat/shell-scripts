#!/bin/bash

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/apt-packages.log"

# Import handlers
source $script_folder/handlers.sh

# ugh
log_message "Installing node"
sudo bash $script_folder/node-install.sh

log_message "Installing git... you should have it if you have this repo."
sudo apt install git -y

log_message "Configuring git"
git config --global user.email "$git_user_email"
git config --global user.name "$git_user_name"

log_message "Installing postgres"
output=$(sudo apt install postgres -y &>> $log_file 2>&1)
error_check "Failed to install postgres. Output: $output"

log_message "Installing snap"
output=$(sudo apt install snap -y &>> $log_file 2>&1)
error_check "Failed to install snap. Output: $output"

log_message "Installing certbot"
output=$(sudo snap install certbot &>> $log_file 2>&1)
error_check "Failed to install certbot. Output: $output"