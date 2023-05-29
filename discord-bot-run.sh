#!/bin/bash

# This script is for running serene-bot-2. If you have a discord bot yourself, modify the directory as you wish.

# Get the log_file
log_file="$LOG_FOLDER/discord-bot-run.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# Check if you have tmux installed.
if ! command -v tmux &> /dev/null; then
    log_message "tmux is not installed. Please install tmux to use this script."
    exit 1
fi

# Change directory
log_message "Changing directory to bot directory..."
cd "$DISCORD_FOLDER/$DISCORD_BOT_REPO"

# Git fetch and pull
log_message "Fetching and pulling from Git..."
output=$(git fetch &>> $log_file 2>&1)
error_check "Failed to fetch from Git. Output: $output"
output=$(git pull &>> $log_file 2>&1)
error_check "Failed to pull from Git. Output: $output"

# Run npm update
log_message "Running npm update..."
output=$(npm run update &>> $log_file 2>&1)
error_check "Failed to run npm update. Output: $output"

# Build with TypeScript
log_message "Building TypeScript..."
output=$(tsc --build &>> $log_file 2>&1)
error_check "Failed to build TypeScript. Output: $output"

# Create tmux session and start the bot
log_message "Starting Discord bot..."
output=$(tmux new-session -d -s $SESSION_NAME_DISCORD "nodemon dist/start.js --watch dist/" &>> $log_file 2>&1)
error_check "Failed to start Discord bot. Output: $output"

# Change directory back to home
log_message "Returning home..."
cd $SCRIPT_FOLDER
# If you can't go back to your home directory, you have some other problems on your system man.

log_message "discord-bot-run executed successfully!"