#!/bin/bash
set -euo pipefail

SCRIPT_PATH=/etc/gitea/scripts

function git_repair() {
    mkdir -p /data/git
    chown git /data/git
    chgrp git /data/git
}

function main() {
    git_repair

    su git -c "sh $SCRIPT_PATH/init-conf.sh"
}

main