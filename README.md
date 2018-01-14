# OpenSIPS Docker Image with MySQL

This docker image is quite the [official one](https://github.com/OpenSIPS/docker-opensips) with support for MySQL.


## Building the image
You can build the docker image by running:
```
make build
```

This command will build a docker image with OpenSIPS master version taken from
the git repository. To build a different git version, you can run:
```
OPENSIPS_VERSION=2.2 make build
```
