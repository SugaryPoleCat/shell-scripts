#!/bin/bash

if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Please install tmux to use this script."
    exit 1
fi

cd $WEBSITES_FOLDER/$WEBSITE_REPO_TEST
npm i
tsc --build
cd vue
npm i
npm run build
cd ../
tmux new-session -d -s $SESSION_NAME_WEBSITE "nodemon dist/server.js --watch dist/"
cd $HOME