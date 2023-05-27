#!/bin/bash

# This script is for running serene-bot-2. If you have a discord bot yourself, modify the directory as you wish.

# Get the log_file
logfolder="~/LOGS"
log_file="$logfolder/discord-bot-run.log"

# Import handlers
source ./handlers.sh

# Change directory
bot_directory="~/PROGRAMMING/DISCORD"
bot_repo="serene-bot-2"
log_message "Changing directory to bot directory..."
cd "$bot_directory/$bot_repo/"
error_check "Failed to change directory"

# Git fetch and pull
log_message "Fetching and pulling from Git..."
git fetch &>> "$log_file"
error_check "Failed to fetch from Git"
git pull &>> "$log_file"
error_check "Failed to pull from Git"

# Run npm update
log_message "Running npm update..."
npm run update &>> "$log_file"
error_check "Failed to run npm update"

# Build with TypeScript
log_message "Building TypeScript..."
tsc --build &>> "$log_file"
error_check "Failed to build TypeScript"

# Create tmux session and start the bot
log_message "Starting Discord bot..."
tmux new-session -d -s discord-bot "nodemon dist/start.js --watch dist/"
error_check "Failed to start Discord bot"

# Change directory back to home
log_message "Returning home..."
cd ~
error_check "Failed to return to home directory"
# If you can't go back to your home directory, you have some other problems on your system man.

log_message "discord-bot-run exectued successfully!"