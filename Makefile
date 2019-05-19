# Makefile for carbonapi docker builds.
CONTAINER  := carbonapi
IMAGE_NAME := $(CONTAINER)
BUILD_NAME := "$(IMAGE_NAME)-build"
DATA_DIR   := $(shell pwd)
DOCKER     := docker
HUB_USER   := $(USER)
MAINTAINER := "Fredrik Lundhag <f@mekk.com>"
VERSION	   := 0.11.0
TAG		   := $(VERSION)


build:
	if $(DOCKER) ps -a |grep -q $(BUILD_NAME); \
		then echo $(BUILD_NAME) exist, skipping; \
		else $(DOCKER) run --name $(BUILD_NAME) golang sh -c "go get github.com/go-graphite/carbonapi ; \
		cd /go/src/github.com/go-graphite/carbonapi ; \
		git checkout tags/$(VERSION) -b v$(VERSION); \
		CGO_ENABLED=0 GOOS=linux \
		go get -ldflags \"-s\" -a -installsuffix cgo github.com/go-graphite/carbonapi"; \
  fi

	$(DOCKER) cp $(BUILD_NAME):/go/bin/carbonapi .
	$(DOCKER) cp $(BUILD_NAME):/go/src/github.com/go-graphite/carbonapi/graphiteWeb.example.yaml files/
	$(DOCKER) cp $(BUILD_NAME):/go/src/github.com/go-graphite/carbonapi/graphTemplates.example.yaml files/

	$(DOCKER)	build --rm \
		--tag=$(IMAGE_NAME) \
		--tag=$(IMAGE_NAME):$(VERSION) \
		.

run:
	$(DOCKER) \
		run \
		--rm \
		--tty \
		--interactive \
		--user $(id -u):$(id -g) \
		--publish=8081:8081 \
		--hostname=${CONTAINER} \
		--name=${CONTAINER} \
		$(IMAGE_NAME)

stop:
	$(DOCKER) \
		kill ${CONTAINER}

history:
	$(DOCKER) \
		history ${IMAGE_NAME}

clean:
	-$(DOCKER) rmi --force $(IMAGE_NAME)
	-$(DOCKER) rmi --force $(IMAGE_NAME):${VERSION}
	-$(DOCKER) rm  --force $(BUILD_NAME)
	-$(DOCKER) rm  --force $(HUB_USER)/$(BUILD_NAME)

push:
	$(DOCKER) tag $(CONTAINER) $(HUB_USER)/$(CONTAINER):$(TAG) && \
	$(DOCKER) tag ${CONTAINER} ${HUB_USER}/${CONTAINER}:latest && \
	$(DOCKER) push $(HUB_USER)/$(CONTAINER):$(TAG) && \
	$(DOCKER) push ${HUB_USER}/${CONTAINER}:latest
