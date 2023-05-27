#!/bin/bash

# This script is for updating the global npm packages.

# Get the log_file
logfolder="~/LOGS"
log_file="$logfolder/npm-update.log"

# Import handlers
source ./handlers.sh

# Basically, I haven't found a better way to get newest versions of packages, other than uninstalling and then installing them again...
# Add/remove packages you want/don't want to use.

# Uninstall packages
log_message "Uninstalling packages..."
sudo npm uninstall -g nodemon typescript @vue/cli sequelize-cli eslint
error_check "Failed to uninstall packages"

# Install all packages again
log_message "Installing packages..."
sudo npm i -g nodemon typescript @vue/cli sequelize-cli eslint
error_check "Failed to install packages"

log_message "Global npm package update successful!"
