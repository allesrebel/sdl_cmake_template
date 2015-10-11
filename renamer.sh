#!/bin/bash
echo "What is the new project name? "
read NEW
echo "Creating template for $input..."

cd ..

OLD="sdl_cmake_template"

cp -r "$OLD" "$NEW"

cd "$NEW"
sed -i.bak "s/$OLD/$NEW/g" CMakeLists.txt

echo "Cleaning up..."
[[ -f CMakeLists.txt.bak ]] && rm -f CMakeLists.txt.bak
[[ -f renamer.sh ]] && rm -f renamer.sh
echo "Done!"