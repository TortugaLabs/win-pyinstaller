IMAGE = win-pyinstaller
BUILD_X_ARGS =
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
