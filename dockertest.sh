#!/bin/sh
docker build --no-cache -t chapter2 .
#docker run -it --entrypoint /bin/bash chapter2
docker build --no-cache -f Dockerfile.Ubuntu20.04 -t chapter2 .
#docker run -it --entrypoint /bin/bash chapter2
docker build --no-cache -f Dockerfile.debian -t chapter2 .
#docker run -it --entrypoint /bin/bash chapter2
