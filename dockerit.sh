#!/bin/sh
docker build -t chapter2 .
docker run -it --entrypoint /bin/bash chapter2
