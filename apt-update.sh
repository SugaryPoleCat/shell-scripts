#!/bin/bash

# This script is for updating debian packages.
# It's pretty terrible right now, doesn't even handle automatic Y'eing to questions.

# Get the log_file
logfolder="~/LOGS"
log_file="$logfolder/apt-update.log"

# Import handlers
source ./handlers.sh

# Update packages
log_message "Updating packages..."
sudo apt update
error_check "Failed to update packages"

# Upgrade packages
log_message "Upgrading packages..."
sudo apt upgrade
error_check "Failed to upgrade packages"

# Auto-remove useless leftovers
log_message "Removing leftovers..."
sudo apt auto-remove
error_check "Failed to auto-remove leftovers"

log_message "Global npm package update successful!"
