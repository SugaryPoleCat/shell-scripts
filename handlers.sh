#!/bin/bash

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