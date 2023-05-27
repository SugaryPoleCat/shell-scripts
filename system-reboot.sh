#!/bin/bash

# Get the log_file
logfolder="~/LOGS"
log_file="$logfolder/system-reboot.log"

# Import handlers
source ./handlers.sh

# Here i'll put the other things.

# Reboot
log_message "Rebooting system"
sudo reboot -f