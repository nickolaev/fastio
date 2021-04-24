FROM ubuntu:20.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    make git gcc clang llvm \
    libssl-dev bc libelf-dev libcap-dev libbfd-dev \
    libncurses5-dev libmnl-dev \
    pkg-config bison flex graphviz

COPY sockredir /root/sockredir
COPY scripts /root/scripts

USER root:root

ENTRYPOINT [ "/bin/bash" ]
