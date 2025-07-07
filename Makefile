# host targets

.PHONY: docker
docker:
	./docker/build.sh

.PHONY: clean
clean:
	rm -rf public resources

.PHONY: distclean
distclean: clean
	rm -rf node_modules

# container targets

.PHONY: all
all: build

.PHONY: build
build:
	hugo/mkdeps.sh
	hugo/build.sh

.PHONY: check
check:
	shellcheck hugo/*.sh
	tsc --noEmit
	npm audit
