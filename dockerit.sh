#!/bin/sh
docker build -f Dockerfile.Ubuntu20.04 -t chapter2 .
docker run -it --entrypoint /bin/bash chapter2
