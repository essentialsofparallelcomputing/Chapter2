FROM ubuntu:18.04 AS builder
WORKDIR /project
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && \
    apt-get -qq install -y cmake make git vim gcc g++ gfortran software-properties-common wget gnupg-agent valgrind \
            mpich libmpich-dev \
            openmpi-bin openmpi-doc libopenmpi-dev

# Installing latest GCC compiler (version 10)
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get -qq install -y gcc-10 g++-10 gfortran-10

# We are installing both OpenMPI and MPICH. We could use the update alternatives to switch between them
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 80 \
                        --slave /usr/bin/g++ g++ /usr/bin/g++-7 \
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-7 \
                        --slave /usr/bin/gcov gcov /usr/bin/gcov-7

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 90\
                        --slave /usr/bin/g++ g++ /usr/bin/g++-10\
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-10\
                        --slave /usr/bin/gcov gcov /usr/bin/gcov-10

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN wget -q ftp://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz
RUN tar -xzf ndiff-2.00.tar.gz
WORKDIR /project/ndiff-2.00
RUN mkdir -p /usr/local/man/man1
RUN ./configure && make && make install
WORKDIR /project
RUN rm -rf ndiff-2.00

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
