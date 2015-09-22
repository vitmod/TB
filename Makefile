BUILD_DIRS=build.*

all: release

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps
