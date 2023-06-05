#!/bin/bash

if [ ! -d "$LOG_FOLDER" ]; then
	mkdir "$LOG_FOLDER"
fi

# Get the log_file
log_file="$LOG_FOLDER/system-initialize.log"

# Import handlers
source $SCRIPT_FOLDER/handlers.sh

# Oof

bash $SCRIPT_FOLDER/apt-update.sh
bash $SCRIPT_FOLDER/apt-packages.sh
bash $SCRIPT_FOLDER/npm-update.sh

log_file="$LOG_FOLDER/system-initialize.log"

git config pull.rebase false
git config user.email "$GIT_USER_EMAIL"
git config user.name "$GIT_USER_NAME"

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

# DONT FORGET TO CONFIGURE YOUR SSH-KEY FIRST!!!
# And upload those keys to your git websites.

cd $DISCORD_FOLDER
git clone $GIT_HUB/$DISCORD_BOT_REPO

cd $WEBSITES_FOLDER
git clone $GIT_HUB/$WEBSITE_REPO_TEST

cd $SCRIPT_FOLDER
# not sure about those things being necessary
bash $SCRIPT_FOLDER/discord-bot-run.sh
bash $SCRIPT_FOLDER/website-test-run.sh
# bash $SCRIPT_FOLDER/postgres.sh

echo "Dont forget to configure NGINX and Certbot manually!!!" &>> $log_file
echo "To configure certbot run: sudo certbot --nginx, follow instructions, then go ahead and test if renewing the certification works with: sudo certbot renew --dry-run"

# Create the thing for the website stuff