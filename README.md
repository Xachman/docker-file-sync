# SSHFS file sync

This project uses unison and sshfs to sync files from linux to windows Mac(not tested but should work) or linux.  


## Usage

~~~
docker run --rm --privileged -e TARGET=user@hostip:/path/to/files \
    -v /path/to/id_rsa:/root/.ssh/id_rsa \
    -v /path/to/known_hosts:/root/.ssh/known_hosts \
    -v /path/to/monunt/on/host:/unison \
    -v /path/to/default.prf:/root/.unison/default.prf \ 
    xachman/docker-file-sync
~~~
### Compose
~~~
sync:
  image: xachman/docker-file-sync
  privileged: true
  volumes:
    - /path/to/id_rsa:/root/.ssh/id_rsa
    - /path/to/known_hosts:/root/.ssh/known_hosts
    - /path/to/default.prf:/root/.unison/default.prf
    - /path/to/files/on/host:/unison
  environment:
    TARGET: user@hostip:/path/to/files
~~~

### Building 

On docker for windows I had to first build a sync container because of permissions when using a volume for host id_rsa

~~~
FROM xachman/docker-file-sync

COPY ./pemkey /root/.ssh/id_rsa
COPY ./known_hosts /root/.ssh/known_hosts

RUN chmod 600 /root/.ssh/
~~~

If we build with 

~~~
docker build -t sync-container .
~~~

Then we can use docker-compose with that image

~~~
sync:
  image: sync-container
  privileged: true
  volumes:
    - /path/to/default.prf:/root/.unison/default.prf
    - /path/to/files/on/host:/unison
  environment:
    TARGET: user@hostip:/path/to/files
~~~