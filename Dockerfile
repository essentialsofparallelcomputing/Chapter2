FROM ubuntu:18.04 AS builder
WORKDIR /project
RUN apt-get update && \
    apt-get install -y bash cmake git software-properties-common openmpi-bin openmpi-doc libopenmpi-dev g++ vim wget valgrind && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update && \
    apt-get install -y gcc-9 g++-9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9

RUN wget -q ftp://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz
RUN tar -xzf ndiff-2.00.tar.gz
WORKDIR /project/ndiff-2.00
RUN ./configure && make

SHELL ["/bin/bash", "-c"]
ENV PATH /project/ndiff-2.00:$PATH

RUN groupadd chapter2 && useradd -m -s /bin/bash -g chapter2 chapter2

WORKDIR /home/chapter2
RUN chown -R chapter2:chapter2 /home/chapter2
USER chapter2

RUN git clone https://github.com/essentialsofparallelcomputing/Chapter2.git

RUN mkdir /home/chapter2/Chapter2/Listing1/build
WORKDIR /home/chapter2/Chapter2/Listing1/build
RUN cmake .. && make

RUN mkdir /home/chapter2/Chapter2/Listing2/build
WORKDIR /home/chapter2/Chapter2/Listing2/build
RUN cmake .. && make

ENTRYPOINT ["bash"]
