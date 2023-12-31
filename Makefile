.SILENT:
all: shell
# Whether to display docker build output
# QUIET_FLAG = -q
QUIET_FLAG =

shell: build_q
	if [ $(shell docker ps -a -f name=amrl_docker_shell | wc -l) -ne 2 ]; \
	then \
		docker run \
				-dit \
				--name amrl_docker_shell \
				--volume "$(shell pwd)/../":/home/dev \
				--workdir /home/dev \
				-p 10272:10272 \
				--userns="keep-id" \
				amrl_docker_image_tag; \
	fi
	docker exec -it amrl_docker_shell bash -l

root: build_q
	if [ $(shell docker ps -a -f name=amrl_docker_shell | wc -l) -ne 2 ]; \
	then \
			docker run \
					-dit \
					--name amrl_docker_shell \
					amrl_docker_image_tag; \
	fi
	docker exec -u 0 -it amrl_docker_shell bash -l

stop:
	docker container stop amrl_docker_shell
	docker container rm amrl_docker_shell

build:
	docker build $(QUIET_FLAG) --build-arg HOST_UID=$(shell id -u) -t amrl_docker_image_tag .
