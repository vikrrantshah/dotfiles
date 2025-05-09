#!/bin/bash

declare PROJECTPATH=("$HOME/Documents/SeDoMo/sedomo-apps" "$HOME/Documents/Personal/Projects/personal-website")
declare PROJECTS=("sedomo" "personal-website")
declare AVAILABLE=()
declare AVAILABLEPATH=()

j=0
for i in "${!PROJECTPATH[@]}"; do
  DIR="${PROJECTPATH[$I]}"
  if [ -s "$DIR" ]; then
    echo "$j: ${PROJECTS[$i]}"
    AVAILABLE+=("${PROJECTS[$i]}")
    AVAILABLEPATH+=("$DIR")
    ((j += 1))
  fi
done

read -rp "Select project: " PROJECT

cd "${AVAILABLEPATH[$PROJECT]}" || echo "Failed Project not found"

sh "$HOME/tmux-sessionizer/projects/${AVAILABLE[$PROJECT]}.sh"
