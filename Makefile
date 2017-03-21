
CONTAINER  := carbonapi
IMAGE_NAME := $(CONTAINER)
BUILD_NAME := "$(IMAGE_NAME)-build"
DATA_DIR   := $(shell pwd)
DOCKER     := docker

build:
	if $(DOCKER) ps -a |grep -q $(BUILD_NAME); \
		then echo $(BUILD_NAME) exist, skipping; \
		else $(DOCKER) run --name $(BUILD_NAME) golang sh -c "CGO_ENABLED=0 GOOS=linux go get -ldflags \"-s\" -a -installsuffix cgo github.com/dgryski/carbonapi"; \
    fi
	$(DOCKER) cp $(BUILD_NAME):/go/bin/$(CONTAINER) .
	$(DOCKER) \
		build \
		--rm --tag=$(IMAGE_NAME) .
	-rm $(CONTAINER) >/dev/null

run: build 
	$(DOCKER) \
		run \
		--rm \
		--tty \
		--interactive \
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
	-$(DOCKER) rm --force $(BUILD_NAME)
	-$(DOCKER) rmi --force $(BUILD_NAME)
	-$(DOCKER) rmi --force $(registry)/$(BUILD_NAME)
	-$(DOCKER) rmi --force $(registry)/$(IMAGE_NAME)

push:
	$(DOCKER) tag $(IMAGE_NAME) jolt/$(IMAGE_NAME):master && $(DOCKER) tag $(IMAGE_NAME) jolt/$(IMAGE_NAME):latest && $(DOCKER) push jolt/$(IMAGE_NAME)
