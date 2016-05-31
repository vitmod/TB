BUILD_DIRS=build.*

all:
	./scripts/image

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps
