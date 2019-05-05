FROM ubuntu AS builder
WORKDIR /project
RUN apt-get update && \
    apt-get install -y bash git cmake git openmpi-bin openmpi-doc libopenmpi-dev g++ vim wget valgrind
RUN git clone https://github.com/essentialsofparallelcomputing/Chapter2.git
RUN wget ftp://ftp.math.utah.edu/pub/misc/ndiff-2.00.tar.gz; tar -xzvf ndiff-2.00.tar.gz; cd ndiff-2.00; ./configure; make
ENV PATH /project/ndiff-2.00:$PATH
RUN cd Chapter2/Listing1 && mkdir build && cd build && cmake .. && make && cd ../..
RUN cd Chapter2/Listing2 && mkdir build && cd build && cmake .. && make && cd ../..
RUN cd Chapter2/Listing3 && cd ../..

RUN bash

ENTRYPOINT ["bash"]
