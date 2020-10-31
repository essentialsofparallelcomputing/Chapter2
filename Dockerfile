# Part of the examples from the Parallel and High Performance Computing
# Robey and Zamora, Manning Publications
#   https://github.com/EssentialsofParallelComputing/Chapter2
#
# The built image can be found at:
#
#   https://hub.docker.com/r/essentialsofparallelcomputing/chapter2
#
# Author:
# Bob Robey <brobey@earthlink.net>

FROM ubuntu:20.04 AS builder

ARG DOCKER_LANG=en_US
ARG DOCKER_TIMEZONE=America/Denver

WORKDIR /tmp
RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -qq install -y locales tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG=$DOCKER_LANG.UTF-8 \
    LANGUAGE=$DOCKER_LANG:UTF-8

RUN ln -fs /usr/share/zoneinfo/$DOCKER_TIMEZONE /etc/localtime && \
    locale-gen $LANG && update-locale LANG=$LANG && \
    dpkg-reconfigure -f noninteractive locales tzdata

ENV LC_ALL=$DOCKER_LANG.UTF-8

RUN apt-get -qq update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get -qq install -y cmake make git vim gcc g++ gfortran wget gnupg-agent valgrind \
            mpich libmpich-dev \
            openmpi-bin openmpi-doc libopenmpi-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installing latest GCC compiler (version 10)
RUN apt-get -qq update && \
    apt-get -qq install -y gcc-10 g++-10 gfortran-10 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN update-alternatives \
      --install /usr/bin/gcc      gcc      /usr/bin/gcc-9       80 \
      --slave   /usr/bin/g++      g++      /usr/bin/g++-9          \
      --slave   /usr/bin/gfortran gfortran /usr/bin/gfortran-9     \
      --slave   /usr/bin/gcov     gcov     /usr/bin/gcov-9      && \
    update-alternatives \
      --install /usr/bin/gcc      gcc      /usr/bin/gcc-10      90 \
      --slave   /usr/bin/g++      g++      /usr/bin/g++-10         \
      --slave   /usr/bin/gfortran gfortran /usr/bin/gfortran-10    \
      --slave   /usr/bin/gcov     gcov     /usr/bin/gcov-10     && \
    chmod u+s /usr/bin/update-alternatives

RUN wget -q http://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz && \
    tar -xzf ndiff-2.00.tar.gz && cd ndiff-2.00 && \
    mkdir -p /usr/local/man/man1 && \
    ./configure && make && make install && cd .. && rm -rf ndiff-2.00

SHELL ["/bin/bash", "-c"]

RUN groupadd -r chapter2 && useradd -r -m -s /bin/bash -g chapter2 chapter2

ARG DOCKER_USER=chapter2
WORKDIR /home/$DOCKER_USER
RUN chown -R $DOCKER_USER:$DOCKER_USER /home/$DOCKER_USER
USER $DOCKER_USER

RUN git clone --recursive https://github.com/essentialsofparallelcomputing/Chapter2.git

WORKDIR /home/$DOCKER_USER/Chapter2
# Uncomment for testing
#RUN make

ENTRYPOINT ["bash"]
