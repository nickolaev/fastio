SHELL := /bin/bash

PWD = $(shell pwd)
DOCKER_IMAGE = fastio:latest
KERNEL_GIT = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
KERNEL_PATH = linux

BUILDX_BUILDER = fastio
# BUILDX_PLATFORMS = linux/arm64 linux/amd64
# BUILDX_PLATFORMS = linux/amd64


.PHONY: all
all: dockerfile

.PHONY: kernel
kernel:
	if [ -d  "$(KERNEL_PATH)" ]; then \
		pushd "$(KERNEL_PATH)" && \
		git fetch origin && \
		git reset --hard origin/master && \
		popd;\
	else \
		git clone $(KERNEL_GIT); \
	fi

.PHONY: docker
docker:
	DOCKER_BUILDKIT=1 docker build -t ${DOCKER_IMAGE} .; \
	# docker buildx create --name $(BUILDX_BUILDER) --use || true
	# for platform in $(BUILDX_PLATFORMS); do \
	# 	 DOCKER_BUILDKIT=1 docker buildx build --platform $$platform --load -t ${DOCKER_IMAGE} .; \
	# done
	# docker buildx rm $(BUILDX_BUILDER)

.PHONY: run
run: kernel docker	
	docker run \
	-it --rm --privileged \
	--mount type=bind,source="$(PWD)"/"$(KERNEL_PATH)",target=/root/linux \
	${DOCKER_IMAGE}; \
