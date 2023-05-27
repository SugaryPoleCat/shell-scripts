#!/bin/bash

# This will -- eh im getting tired of writing these commands what the scirpt does, i mean you can see the code and stuff.
# Right? Right.

# Get the log_file
logfolder="~/LOGS"
log_file="$logfolder/discord-bot-stop.log"

# Import handlers
source ./handlers.sh

# This will send a command to tmux to close the discord-bot window.
session_name="discord-bot"
log_message "Sending CTRL+C to tmux window!"
tmux send-keys -t "$session_name" C-c # C-c is the command. C = CTRL, c = c.
error_check "Failed to send CTRL+C to tmux window."

sleep 1  # Wait for the command to take effect

# Now let's also kill the session
log_message "Killing tmux session!"
tmux kill-session -t "$session_name"
error_check "Failed to kill the tmux session."

log_message "discord-bot-stop executed successfully!"