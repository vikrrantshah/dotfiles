#!/bin/bash

declare PROJECTPATH=(
  "$HOME/.dotfiles"
  "$HOME/Documents/Arbio"
  "$HOME/Documents/Arbio"
  "$HOME/Documents/SeDoMo/sedomo-apps"
  "$HOME/Documents/Personal/Projects/side-pdf"
  "$HOME/Documents/Personal/Projects/personal-website"
)
declare PROJECTS=(
  "dotfiles"
  "arbio-web"
  "arbio-nexus"
  "sedomo"
  "side-pdf"
  "personal-website"
)
declare AVAILABLE=()
declare AVAILABLEPATH=()

j=0
for i in "${!PROJECTPATH[@]}"; do
  DIR="${PROJECTPATH[$i]}"
  if [ -s "$DIR" ]; then
    echo "$j: ${PROJECTS[$i]}"
    AVAILABLE+=("${PROJECTS[$i]}")
    AVAILABLEPATH+=("$DIR")
    ((j += 1))
  fi
done

read -rp "Select session: " PROJECT

path="$HOME/tmux-sessionizer/projects/${AVAILABLE[$PROJECT]}.sh"

if [ ! -f "$path" ]; then
  echo "Start script for project ${AVAILABLE[$PROJECT]} not found please check you configuration"
  exit 1
fi

cd "${AVAILABLEPATH[$PROJECT]}" || echo "Failed Project not found"

sh "$path"
