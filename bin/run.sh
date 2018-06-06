#!/bin/sh

set -eo pipefail
echo "Starting application in apprunner..."

### ---------------- ###
### Downloading Slug ###
### ---------------- ###
export HOME=/app
mkdir -p $HOME
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

### -------------- ###
### Setting Limits ###
### -------------- ###
if [ -e /sys/fs/cgroup/memory/memory.limit_in_bytes ]; then
    mem_limit_bytes=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
    mem_limit_Mbytes=$((${mem_limit_bytes} / 1048576))
else
    mem_limit_Mbytes=512
fi

### ----------------- ###
### Running Component ###
### ----------------- ###
export PATH="$HOME/.heroku/node/bin:$HOME/bin:$HOME/node_modules/.bin:$PATH"
export NODE_HOME="$HOME/.heroku/node"

node () {
    $(command -v node) --max-old-space-size=${mem_limit_Mbytes} "$@"
}

java () {
    $(command -v java) -Xms${mem_limit_Mbytes}M -Xmx${mem_limit_Mbytes}M "$@"
}

exec "$@"