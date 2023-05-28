#!/bin/bash

# Get the log_file
log_file="$LOG_FOLDER/discord-bot-stop.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

log_message "Getting node's link and installing it"
sudo curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash - &&\
sudo apt-get install -y nodejs
log_message "Node has been installed"