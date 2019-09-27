FROM ubuntu:18.04 as xyce_deps

RUN apt-get update && apt-get install -yq gcc g++ gfortran make cmake bison flex libfl-dev libfftw3-dev libsuitesparse-dev libblas-dev liblapack-dev libtool automake autoconf && apt-get clean

FROM xyce_deps as trillinos_git

RUN apt-get install -yq git && apt-get clean

RUN \
    mkdir -p /opt/Xyce && \
    cd /opt/Xyce && \
    git clone https://github.com/trilinos/Trilinos.git && \
    cd Trilinos && \
    git checkout trilinos-release-12-12-branch

FROM trillinos_git as trillinos_build

COPY reconfig.sh /opt/Xyce/

RUN \
    cd /opt/Xyce && \
    mkdir build && \
    cd build && \
    bash ../reconfig.sh && \
    make && \
    make install && \
    cd .. && rm -rf Trilinos build

FROM trillinos_build as xyce

RUN \
    cd /opt/Xyce && \
    git clone http://github.com/Xyce/Xyce.git --branch Release-6.11.1 Xyce-6.11.1 && \
    cd Xyce-6.11.1 && \
    ./bootstrap && \
    mkdir build && \
    cd build && \
    ../configure CXXFLAGS="-O3" ARCHDIR="/opt/Xyce/XyceLibs/Serial" CPPFLAGS="-I/usr/include/suitesparse" && \
    make && \
    make install && \
    cd .. && \
    rm -rf build && \
    cd .. && rm -rf Xyce-6.11.1

