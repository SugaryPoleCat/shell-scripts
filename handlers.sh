#!/bin/bash

# This script is meant to be reused in other files.
source /home/rayine/shell-scripts/variables.sh

# Check if we have a LOGS folder in home directory, if not, create it.
log_folder="$home_folder/LOGS"
if[ ! -d "$log_folder" ]; then
	mkdir "$log_folder"
fi

# Function to log messages
log_message() {
    local timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] $1" >> "$log_file"
}

# Function to check for errors and exit if there are any.
error_check() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_message "Error: $1!"
        exit $exit_code
    fi
}