#!/bin/bash

run_unison="unison -auto -batch /mnt/droplet /unison"
run_sftp="sshfs -o allow_other,default_permissions $TARGET /mnt/droplet"
echo "$run_sftp"
if [ -n "$TARGET" ]; then
    $run_sftp
    $run_unison
    while sleep 1; do $run_unison; done
else
    echo "No TARGET variable"
    exit 1
fi