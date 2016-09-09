#!/bin/bash
set -e

mem_limit_bytes=`cat /sys/fs/cgroup/memory/memory.limit_in_bytes`
mem_limit_Mbytes=`expr $mem_limit_bytes / 1048576`

node () {
    `which node` --max-old-space-size=$mem_limit_Mbytes $@
}
java () {
    `which java` -Xms${mem_limit_Mbytes}M -Xmx${mem_limit_Mbytes}M $@
}

echo "Starting the application with ${command}"
python -c 'import os; import SimpleHTTPServer; import SocketServer; os.chdir("/tmp"); PORT = 9001; Handler = SimpleHTTPServer.SimpleHTTPRequestHandler; httpd = SocketServer.TCPServer(("", PORT), Handler); httpd.serve_forever()' > /dev/null 2>&1 &
$command
