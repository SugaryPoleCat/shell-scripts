#!/bin/bash

# Create a database and stuff automatically.
sudo -u postgres createuser $POSTGRES_USERNAME
sudo -u postgres createdb $POSTGRES_DATABASE
sudo -u postgres psql <<EOF
ALTER USER $POSTGRES_USERNAME WITH ENCRYPTED PASSWORD '$POSTGRES_PASSWORD';\q
EOF
sudo -u postgres psql <<EOF
GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DATABASE TO $POSTGRES_USERNAME;\q
EOF