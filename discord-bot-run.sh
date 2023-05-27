#!/bin/bash

folder="~/LOGS"
if[ ! -d "$folder" ]; then
	mkdir "$folder"

log_file="$folder/discord-bot-run.log"

# Function to log messages
log_message() {
    local timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] $1" >> "$log_file"
}

# Change directory
cd ~/PROGRAMMING/DISCORD/serene-bot-2/ || {
    log_message "Error: Failed to change directory."
    exit 1
}

# Git fetch and pull
log_message "Fetching from Git..."
git fetch &>> "$log_file"
git pull &>> "$log_file" || {
    log_message "Error: Failed to pull from Git."
    exit 1
}

# Run npm update
log_message "Running npm update..."
npm run update &>> "$log_file" || {
    log_message "Error: Failed to run npm update."
    exit 1
}

# Build with TypeScript
log_message "Building TypeScript..."
tsc --build &>> "$log_file" || {
    log_message "Error: Failed to build TypeScript."
    exit 1
}

# Create tmux session and start the bot
log_message "Starting Discord bot..."
tmux new-session -d -s discord-bot "nodemon dist/start.js --watch dist/" || {
    log_message "Error: Failed to start Discord bot."
    exit 1
}

# Change directory back to home
cd ~ || {
    log_message "Error: Failed to change directory."
    exit 1
}

log_message "Script executed successfully."
