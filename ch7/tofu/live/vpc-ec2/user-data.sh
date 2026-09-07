#!/usr/bin/env bash

set -ex

su app-user <<'EOF'

cd /home/app-user/sample-app

pwd
which node
node --version
which pm2
pm2 --version

pm2 start app.config.js
pm2 save

EOF