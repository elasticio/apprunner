#!/bin/bash
set -e
if [[ -e /sys/fs/cgroup/memory/memory.limit_in_bytes ]]; then
    mem_limit_bytes=`cat /sys/fs/cgroup/memory/memory.limit_in_bytes`
    mem_limit_Mbytes=`expr $mem_limit_bytes / 1048576`
else 
    mem_limit_Mbytes=512
fi

node () {
    `which node` --max-old-space-size=$mem_limit_Mbytes $@
}
java () {
    `which java` -Xms${mem_limit_Mbytes}M -Xmx${mem_limit_Mbytes}M $@
}

echo "Starting the application with ${command}"
exec $command
