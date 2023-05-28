#!/bin/bash

if [ ! -d "$LOG_FOLDER" ]; then
	mkdir "$LOG_FOLDER"
fi

# Get the log_file
log_file="$LOG_FOLDER/apt-update.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# Oof

bash $SCRIPT_FOLDER/node-install.sh
bash $SCRIPT_FOLDER/apt-update.sh
bash $SCRIPT_FOLDER/apt-packages.sh

# git repos
if [ ! -d $PROGRAMMING_FOLDER ]; then
	mkdir $PROGRAMMING_FOLDER
fi

if [ ! -d $DISCORD_FOLDER ]; then
	mkdir $DISCORD_FOLDER
fi

if [ ! -d $WEBSITES_FOLDER ]; then
	mkdir $WEBSITES_FOLDER
fi

cd $DISCORD_FOLDER
git clone $GIT_HUB/$DISCORD_BOT_REPO

cd $WEBSITES_FOLDER
git clone $GIT_HUB/$WEBSITE_REPO_TEST

cd $SCRIPT_FOLDER
# not sure about those things being necessary
# sudo bash $SCRIPT_FOLDER/discord-bot-run.sh

# Create the thing for the website stuff