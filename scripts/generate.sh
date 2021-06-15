#!/usr/bin/env bash

SRC=$1
INC=$2

go run github.com/cilium/ebpf/cmd/bpf2go fastio \
  ${SRC}/bpf_redir.c -- \
  -I${INC} -I./include/lib -nostdinc -O0 -g \
  -D__NR_CPUS__=$(nproc --all) \
  -DSKIP_DEBUG \
  -DHAVE_LPM_TRIE_MAP_TYPE \
  -DHAVE_LRU_HASH_MAP_TYPE \
  -DENABLE_IPV4 \
  -DENABLE_IPV6 \
  -DENCAP_IFINDEX=1