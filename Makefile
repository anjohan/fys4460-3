MAKEFLAGS += --silent
all:
	@mkdir -p build
	@cd build; cmake ..; make
debug:
	@mkdir -p debug_folder
	@cd debug_folder; cmake -DCMAKE_BUILD_TYPE=Debug ..; make
clean:
	rm -rf build debug debug_folder
