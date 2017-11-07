# SSHFS file sync

This project uses unison and sshfs to sync files from linux to windows Mac(not tested but should work) or linux.  


# Usage

~~~
docker run --rm -e TARGET:user@hostip:/path/to/files \
    -v /path/to/id_rsa:/root/.ssh/id_rsa \
    -v /path/to/known_hosts:/root/.ssh/known_hosts \
    -v /path/to/monunt/on/host:/unison \
    -v /path/to/default.prf:/root/.unison/default.prf \ 
    xachman/docker-file-sync
~~~