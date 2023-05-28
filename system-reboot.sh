#!/bin/bash

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/system-reboot.log"

# Import handlers
source $script_folder/handlers.sh

# Here i'll put the  other things.
log_message "Shutting down discord and website..."
output=$(sudo bash $script_folder/discord-bot-stop.sh &>> $log_file 2>&1)
error_check "Failed to shut down discord bot. Output: $output"

# Reboot
log_message "Rebooting system"
sudo reboot -f