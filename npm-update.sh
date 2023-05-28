#!/bin/bash

# This script is for updating the global npm packages.

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/npm-update.log"

# Import handlers
source $script_folder/handlers.sh

# Basically, I haven't found a better way to get newest versions of packages, other than uninstalling and then installing them again...
# Add/remove packages you want/don't want to use.

# Uninstall packages
log_message "Uninstalling packages..."
output=$(sudo npm uninstall -g nodemon typescript @vue/cli sequelize-cli eslint &>> $log_file 2>&1)
error_check "Failed to uninstall packages. Output: $output"

# Install all packages again
log_message "Installing packages..."
output=$(sudo npm i -g nodemon typescript @vue/cli sequelize-cli eslint &>> $log_file 2>&1)
error_check "Failed to install packages. Output: $output"

log_message "Global npm package update successful!"
