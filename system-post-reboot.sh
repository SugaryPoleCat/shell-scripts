#!/bin/bash

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/system-post-reboot.log"

# Import handlers
source $script_folder/handlers.sh

# Array of service names
services=("postgres" "certbot")

# Iterate over each service
for service in "${services[@]}"
do
    # Check service status
    systemctl is-active --quiet "$service" &>> $log_file
    if [ $? -eq 0 ]; then
        log_message "$service is running."
    else
        log_message "$service is not running."
    fi
done

# Check System Logs
system_log_file="/var/log/syslog"

if [ -f "$system_log_file" ]; then
    log_message "Reading system logs..."
		# Change 20 to how many last logs you want to read.
    log_message $(tail -n 20 "$system_log_file")
else
    log_message "System log file not found."
fi

# Update Software Packages
log_message "Updating software packages..."
sudo bash $script_folder/apt-update.sh

# Review Startup Applications
log_message "Listing startup applications..."
ls /etc/init.d/ &>> $log_file

# Perform System Health Checks
log_message "Running system health checks..."
memtest86 &>> $log_file
fsck -f /dev/sda1 &>> $log_file

# Set System Clock
# log_message "Setting system clock..."
# timedatectl set-time "YYYY-MM-DD HH:MM:SS" &>> $log_file
# timedatectl set-timezone "America/New_York" &>> $log_file

# Monitor Resource Usage
log_message "Monitoring resource usage..."
top -n 1 &>> $log_file

# Test Network Connectivity
log_message "Testing network connectivity..."
ping -c 5 google.com &>> $log_file

# Enable Security Measures
# log_message "Enabling security measures..."
# ufw enable

# Review System Backups
log_message "Reviewing system backups..."
ls /BACKUPS/ &>> $log_file

# After completing main tasks
log_message "Post-reboot main tasks completed."

# Additional tasks
log_message "Now performing additional post reboot tasks."

# The tasks.
sudo bash $script_folder/npm-update.sh
sudo bash $script_folder/discord-bot-run.sh