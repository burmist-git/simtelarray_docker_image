FROM ubuntu

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y patch csh perl gfortran make g++ bc wget git python3-pip vim libgd-dev cmake apt-utils emacs htop

RUN mkdir /simtelarray
ADD corsika7.7_simtelarray_2020-06-28_patch.tar.gz /simtelarray/

RUN cd /simtelarray && \
    ./build_all prod5-lp-sc-baseline qgs2

COPY run_simtelarray /run_simtelarray

RUN cd /run_simtelarray && \
    ./run_simtelarray.sh -simple_test_sim_telarray