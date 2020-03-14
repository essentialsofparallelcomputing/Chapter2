FROM ubuntu:18.04 AS builder
WORKDIR /project
RUN apt-get update && \
    apt-get install -y bash cmake git openmpi-bin openmpi-doc libopenmpi-dev g++ vim wget valgrind && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -q ftp://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz
RUN tar -xzf ndiff-2.00.tar.gz
WORKDIR /project/ndiff-2.00
RUN ./configure && make

SHELL ["/bin/bash", "-c"]
ENV PATH /project/ndiff-2.00:$PATH

RUN groupadd -r chapter2 && useradd -r -s /bin/false -g chapter2 chapter2

WORKDIR /chapter2
RUN chown -R chapter2:chapter2 /chapter2
USER chapter2

RUN git clone https://github.com/essentialsofparallelcomputing/Chapter2.git

RUN mkdir /chapter2/Chapter2/Listing1/build
WORKDIR /chapter2/Chapter2/Listing1/build
RUN cmake .. && make

RUN mkdir /chapter2/Chapter2/Listing2/build
WORKDIR /chapter2/Chapter2/Listing2/build
RUN cmake .. && make

ENTRYPOINT ["bash"]
