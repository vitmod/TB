BUILD_DIRS=build.*

all:
	./scripts/image

image:
	./scripts/image mkimage

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps
