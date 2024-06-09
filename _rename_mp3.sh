#!/bin/bash

# Отримати список всіх mp3 файлів у теці
shopt -s nullglob
files=(*.mp3)
shopt -u nullglob

# Вивести початковий список файлів
echo "Початковий список файлів:"
for file in "${files[@]}"; do
  echo "$file"
done

# Перемішати файли у випадковому порядку
IFS=$'\n' files=( $(shuf -e "${files[@]}") )
unset IFS

# Вивести початковий список файлів
echo "Новий список файлів:"
for file in "${files[@]}"; do
  echo "$file"
done

# Функція для перевірки та додавання індексу
rename_file() {
  local file="$1"
  local index="$2"
  local new_name

  if [[ "$file" =~ ^[0-9]+_(.*)$ ]]; then
    new_name="${index}_${BASH_REMATCH[1]}"
  else
    new_name="${index}_$file"
  fi

  # Вивести старе та нове ім'я файлу
  echo "Перейменування файлу: '$file' -> '$new_name'"

  if [ "$file" != "$new_name" ]; then
    mv "$file" "$new_name"
  fi
}

# Перейменування файлів
for i in "${!files[@]}"; do
  rename_file "${files[$i]}" "$i"
done

echo "Файли успішно перейменовано!"
