#!/bin/bash

# 
# Description: This script renames all mp3 files in the directory by adding an index at the beginning of the filename.
# Owner: Iurii Vlasenko
# License: MIT License
#
# MIT License
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Get a list of all mp3 files in the directory
shopt -s nullglob
files=(*.mp3)
shopt -u nullglob

# Shuffle files in random order
IFS=$'\n' files=( $(shuf -e "${files[@]}") )
unset IFS

# Function for checking and adding an index
rename_file() {
  local file="$1"
  local index="$2"
  local new_name

  if [[ "$file" =~ ^[0-9]+_(.*)$ ]]; then
    new_name="${index}_${BASH_REMATCH[1]}"
  else
    new_name="${index}_$file"
  fi

  # Print old and new file names
  echo "Renaming file: '$file' -> '$new_name'"

  # Check if the file name is different from the new name before renaming
  if [ "$file" != "$new_name" ]; then
    mv "$file" "$new_name"
  fi
}

# Rename files
for i in "${!files[@]}"; do
  rename_file "${files[$i]}" "$i"
done

echo "Files successfully renamed!"
