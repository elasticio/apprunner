#!/bin/sh

set -eo pipefail
echo "Starting application in apprunner..."

### ---------------- ###
### Downloading Slug ###
### ---------------- ###

cd $HOME

if [ "$(ls -A $HOME)" ]; then
    echo "Will try to start app at ${HOME}"
    true
elif [ "${SLUG_URL}" ]; then
    echo "Starting slug download ..."
    curl --noproxy marathon.slave.mesos -L -s --connect-timeout 60 "$SLUG_URL" | tar -xzC $HOME
    echo "Successfully downloaded and extracted slug file"
    unset SLUG_URL
else
    echo "No SLUG_URL was set, will try to read from stdin"
    cat | tar -xzC $HOME
fi

### ----------------- ###
### Running Component ###
### ----------------- ###
export PATH="$HOME/.heroku/node/bin:$HOME/bin:$HOME/node_modules/.bin:$PATH"
export NODE_HOME="$HOME/.heroku/node"

exec $@
