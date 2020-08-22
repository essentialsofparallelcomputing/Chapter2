FROM ubuntu:20.04 AS builder
WORKDIR /tmp
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
    tar -xzf ndiff-2.00.tar.gz && cd /tmp/ndiff-2.00 && \
    mkdir -p /usr/local/man/man1 && \
    ./configure && make && make install && cd .. && rm -rf ndiff-2.00

SHELL ["/bin/bash", "-c"]

RUN groupadd -r chapter2 && useradd -r -m -s /bin/bash -g chapter2 chapter2

WORKDIR /home/chapter2
RUN chown -R chapter2:chapter2 /home/chapter2
USER chapter2

RUN git clone --recursive https://github.com/essentialsofparallelcomputing/Chapter2.git

WORKDIR /home/chapter2/Chapter2
# Uncomment for testing
#RUN make

ENTRYPOINT ["bash"]
