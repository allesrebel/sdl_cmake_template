#!/bin/bash
# Script to run CMake and build the executable

echo "Removing old build files ...."
[ -d build ] && rm -rf build

echo "Building Project using CMake"
mkdir build && cd build
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ../
make
make install