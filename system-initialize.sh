#!/bin/bash

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/apt-update.log"

# Import handlers
source $script_folder/handlers.sh

# Oof

sudo bash $script_folder/node-install.sh
sudo bash $script_folder/apt-packages.sh