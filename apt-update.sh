#!/bin/bash

# This script is for updating debian packages.
# It's pretty terrible right now, doesn't even handle automatic Y'eing to questions.

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/apt-update.log"

# Import handlers
source $script_folder/handlers.sh

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

log_message "Global npm package update successful!"
