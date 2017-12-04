#!/bin/bash

DROPLET="/mnt/droplet"

run_unison="unison -auto -batch -perms 0 $DROPLET /unison"
run_sftp="sshfs -o allow_other,default_permissions $TARGET $DROPLET"
echo "$run_sftp"
if [ -n "$TARGET" ]; then
    $run_sftp
    if [ "$(ls -A $DROPLET)" ]; then 
        $run_unison 
    else
        exit 1
    fi
    while sleep 1; do
        if [ "$(ls -A $DROPLET)" ]; then 
            $run_unison 
        else
            exit 1
        fi
    done
else
    echo "No TARGET variable"
    exit 1
fi