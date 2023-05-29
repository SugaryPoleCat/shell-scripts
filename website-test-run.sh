#!/bin/bash

if ! command -v tmux &> /dev/null; then
    echo "tmux is not installed. Please install tmux to use this script."
    exit 1
fi

# cd $WEBSITES_FOLDER/$WEBSITE_REPO_TEST
cd $WEBSITES_FOLDER/test
npm i
# tsc --build
# cd vue
# npm i
# npm run build
# cd ../
# tmux new-session -d -s $SESSION_NAME_WEBSITE "nodemon dist/server.js --watch dist/"
tmux new-session -d -s webtest "nodemon test.js --watch ."
cd $SCRIPT_FOLDER