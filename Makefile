IMAGE = win-pyinstaller

PYTHON_VERSION = 3.12.4
PYINSTALLER_VERSION = 6.2
UPX_VERSION = 4.2.1

include ./version.mk

BUILD_X_ARGS =	\
		--build-arg PYTHON_VERSION=$(PYTHON_VERSION) \
		--build-arg PYINSTALLER_VERSION=$(PYINSTALLER_VERSION) \
		--build-arg UPX_VERSION=$(UPX_VERSION)

ARGS = cmd

help:
	@echo "Options:"
	@echo "- build : build image"
	@echo "- clean: clean up folder"
	@echo "- run : Run image.  Use ARGS="...opts..."

#~ 	@echo "- start : start container"
#~ 	@echo "- stop : stop container"
#~ 	@echo "- shell: start shell on running container"

build: Dockerfile entrypoint.sh pacman.conf
	docker rmi $(IMAGE) || :
	docker buildx build -t $(IMAGE) $(BUILD_X_ARGS) .

clean:
	docker rmi $(IMAGE) || :

run:
	@echo Running with $(ARGS)
	@echo Use ARGS=... to overrride
	docker run --rm -it \
		-v "$$(pwd)":/src/ \
		$(IMAGE) $(ARGS)
