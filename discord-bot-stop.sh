#!/bin/bash

# This will -- eh im getting tired of writing these commands what the scirpt does, i mean you can see the code and stuff.
# Right? Right.

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/discord-bot-stop.log"

# Import handlers
source $script_folder/handlers.sh

# This will send a command to tmux to close the discord-bot window.
session_name="discord-bot"
log_message "Sending CTRL+C to tmux window!"
output=$(tmux send-keys -t "$session_name" C-c &>> $log_file 2>&1) # C-c is the command. C = CTRL, c = c.
error_check "Failed to send CTRL+C to tmux window. Output: $output"

sleep 1  # Wait for the command to take effect

# Now let's also kill the session
log_message "Killing tmux session!"
output=$(tmux kill-session -t "$session_name" &>> $log_file 2>&1)
error_check "Failed to kill the tmux session. Output: $output"

log_message "discord-bot-stop executed successfully!"