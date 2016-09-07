#!/bin/bash
node () {
    `which node` --max-old-space-size=$COMP_MEM_LIMIT_MB $@
}
$command
