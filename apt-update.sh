#!/bin/bash

# This script is for updating debian packages.
# It's pretty terrible right now, doesn't even handle automatic Y'eing to questions.

# Get the log_file
log_file="$LOG_FOLDER/apt-update.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# Update packages
log_message "Updating packages..."
output=$(sudo apt update &>> $log_file 2>&1)
error_check "Failed to update packages. Output: $output"

# Upgrade packages
log_message "Upgrading packages..."
output=$(sudo apt upgrade -y &>> $log_file 2>&1)
error_check "Failed to upgrade packages. Output: $output"

# Auto-remove useless leftovers
log_message "Removing leftovers..."
output=$(sudo apt auto-remove -y &>> $log_file 2>&1)
error_check "Failed to auto-remove leftovers. Output: $output"

echo "Refreshing snap core" &>> $log_file
output=$(sudo snap refresh core &>> $log_file 2>&1)
error_check "Failed to refresh snap core. Output: $output"

echo "Refreshing certbot" &>> $log_file
output=$(sudo snap refresh certbot &>> $log_file 2>&1)
error_check "Failed to refresh certbot. Output: $output"

echo "Updating npm" &>> $log_file
output=$(bash "$SCRIPT_FOLDER/npm-update.sh" &>> $log_file 2>&1)
error_check "Failed to update npm. Output: $output"

log_message "apt-update completed!"
