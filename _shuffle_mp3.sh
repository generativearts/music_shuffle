#!/bin/bash

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
