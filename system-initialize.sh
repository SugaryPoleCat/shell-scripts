#!/bin/bash

# Variables
source /home/rayine/shell-scripts/variables.sh

# Get the log_file
log_file="$log_folder/apt-update.log"

# Import handlers
source $script_folder/handlers.sh

# Oof

sudo bash $script_folder/node-install.sh
sudo bash $script_folder/apt-update.sh
sudo bash $script_folder/apt-packages.sh

# git repos
if[ ! -d "$repos_folder" ]; then
	mkdir "$repos_folder"
fi

if[ ! -d "$discord_folder" ]; then
	mkdir "$discord_folder"
fi

if[ ! -d "$website_folder" ]; then
	mkdir "$website_folder"
fi

git clone git@github.com:SugaryPoleCat/serene-bot-2