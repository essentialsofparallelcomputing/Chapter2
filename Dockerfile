FROM ubuntu:18.04 AS builder
WORKDIR /project
RUN apt-get update -q && \
    apt-get install -q -y cmake git vim gcc g++ gfortran software-properties-common wget gnupg-agent valgrind \
            mpich libmpich-dev \
            openmpi-bin openmpi-doc libopenmpi-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installing latest GCC compiler (version 9)
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update -q && \
    apt-get install -q -y gcc-9 g++-9 gfortran-9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# We are installing both OpenMPI and MPICH. We could use the update -q-alternatives to switch between them
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90\
                        --slave /usr/bin/g++ g++ /usr/bin/g++-9\
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-9\
                        --slave /usr/bin/gcov gcov /usr/bin/gcov-9

RUN wget -q ftp://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz
RUN tar -xzf ndiff-2.00.tar.gz
WORKDIR /project/ndiff-2.00
RUN ./configure && make

SHELL ["/bin/bash", "-c"]
ENV PATH /project/ndiff-2.00:$PATH

RUN groupadd -r chapter2 && useradd -r -m -s /bin/bash -g chapter2 chapter2

WORKDIR /home/chapter2
RUN chown -R chapter2:chapter2 /home/chapter2
USER chapter2

RUN git clone --recursive https://github.com/essentialsofparallelcomputing/Chapter2.git

WORKDIR /home/chapter2/Chapter2
# Uncomment for testing
#RUN make

ENTRYPOINT ["bash"]
