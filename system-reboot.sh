#!/bin/bash

# Get the log_file
log_file="$LOG_FOLDER/system-reboot.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# Here i'll put the  other things.
log_message "Shutting down discord and website..."
output=$(bash $SCRIPT_FOLDER/discord-bot-stop.sh &>> $log_file 2>&1)
error_check "Failed to shut down discord bot. Output: $output"

# Reboot
log_message "Rebooting system"
sudo reboot -f