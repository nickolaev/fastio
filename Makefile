DOCKER_IMAGE = fastio:latest
KERNEL_GIT = "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
KERNEL_PATH = linux

.PHONY: all
all: dockerfile

.PHONY: kernel
kernel:
	if [ -d  "$(KERNEL_PATH)" ]; then \
		pushd "$(KERNEL_PATH)" && \
		git fetch origin && \
		popd;\
	else \
		git clone $(KERNEL_GIT); \
	fi

.PHONY: dockerfile
dockerfile:
	docker build -t ${DOCKER_IMAGE} .

.PHONY: run
run: kernel
	docker run \
	-it --rm --privileged \
	--mount type=bind,source="$(pwd)"/"$(KERNEL_PATH)",target=/root/linux \
	${DOCKER_IMAGE}