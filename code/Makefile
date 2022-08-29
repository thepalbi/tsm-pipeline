.DEFAULT_GOAL := docker

BUILD_USER       ?= $(shell whoami)@$(shell hostname)
BUILD_DATE       ?= $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_DATE_SHORT ?= $(shell date -u +"%Y%m%d")
GIT_BRANCH       ?= $(shell git rev-parse --abbrev-ref HEAD)
GIT_REVISION     ?= $(shell git rev-parse --short HEAD)

GIT_DIRTY    ?= $(shell git status --porcelain | wc -l)

ifeq ("$(GIT_DIRTY)","0")
	GIT_VERSION ?= $(GIT_REVISION)
else
	GIT_VERSION ?= $(GIT_REVISION)-WIP
endif

SANITIZED_GIT_BRANCH ?= $(shell echo $(GIT_BRANCH) | sed 's/[^a-z^A-Z^\-]/-/g' | sed 's/^\-/x/' )
IMAGE_PREFIX ?= github.com/thepalbi
IMAGE_TAG    ?= $(SANITIZED_GIT_BRANCH)-$(GIT_VERSION)

# Printing
PRINT_BOLD := $(shell tput bold)
PRINT_NORMAL := $(shell tput sgr0)

docker: docker-tsm-main

docker-tsm-main:
	DOCKER_BUILDKIT=1 docker build -t $(IMAGE_PREFIX)/tsm-main -f ./Dockerfile .
	docker tag $(IMAGE_PREFIX)/tsm-main $(IMAGE_PREFIX)/tsm-main:latest
	docker tag $(IMAGE_PREFIX)/tsm-main $(IMAGE_PREFIX)/tsm-main:$(IMAGE_TAG)