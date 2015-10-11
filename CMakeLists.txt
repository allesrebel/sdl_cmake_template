cmake_minimum_required(VERSION 2.6)
project(sdl_cmake_template)

# Use our modified FindSDL2* modules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${sdl_cmake_template_SOURCE_DIR}/cmake")
# Set an output directory for our binaries
set(BIN_DIR ${sdl_cmake_template_SOURCE_DIR}/bin)

# Bump up warning levels appropriately for clang, gcc & msvc
# Also set debug/optimization flags depending on the build type. IDE users choose this when
# selecting the build mode in their IDE
if (${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" OR ${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic -std=c++11")
	set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_DEBUG} -g")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_RELEASE} -O2")
elseif (${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC")
	if (CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
		string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
	else()
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4")
	endif()
endif()

# Look up SDL2 and add the include directory to our include path
find_package(SDL2 REQUIRED)
include_directories(${SDL2_INCLUDE_DIR})

# Add in the source files
file(GLOB_RECURSE sdl_cmake_template_SOURCES "src/*.cpp")
file(GLOB_RECURSE sdl_cmake_template_HEADERS "src/*.h")

set (sdl_cmake_template_INCLUDE_DIRS "")
foreach (_headerFile ${sdl_cmake_template_HEADERS})
    get_filename_component(_dir ${_headerFile} PATH)
    list (APPEND sdl_cmake_template_INCLUDE_DIRS ${_dir})
endforeach()
list(REMOVE_DUPLICATES sdl_cmake_template_INCLUDE_DIRS)
include_directories(${sdl_cmake_template_INCLUDE_DIRS})
add_executable (sdl_cmake_template ${sdl_cmake_template_SOURCES})

target_link_libraries(sdl_cmake_template ${SDL2_LIBRARY})
install(TARGETS sdl_cmake_template RUNTIME DESTINATION ${BIN_DIR})
