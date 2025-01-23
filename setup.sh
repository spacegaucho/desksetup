#!/bin/bash
# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script/246128#246128
BASE_NAME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source ./config.sh
source ./files/misc/stdlib.bash

select_scripts () {
  TARGET_DIR="${BASE_NAME}/scripts"

  # https://chatgpt.com/c/674e74d7-8f10-800f-b28d-eb7cb9e12b9a
  # Generate file list for the checklist
  FILE_LIST=()
  for file in "$TARGET_DIR"/*; do
      # Add each file as an option with OFF as the default state
      if echo "$file" | &>/dev/null grep 'install-'
      then
        FILE_LIST+=("$(basename "$file")" "File" "OFF")
      fi
  done

  # Check if there are files to display
  if [ ${#FILE_LIST[@]} -eq 0 ]; then
      echo "No files found in the directory."
      exit 1
  fi

  # Display the checklist dialog
  SELECTED=$(whiptail --title "File Selector" \
      --checklist "Select files:" 20 78 15 \
      "${FILE_LIST[@]}" \
      3>&1 1>&2 2>&3)

  # Check the exit status to handle Cancel
  if [ $? -ne 0 ]; then
      echo "Selection canceled."
      exit 1
  fi

  # Process the selected files
  if [ -n "$SELECTED" ]; then
      for file in $SELECTED; do
          echo "$TARGET_DIR/${file//\"/}"
      done
  else
      echo "No files selected."
  fi
}

run_selected () {
  for script in ${1}
  do
    source ${script}
  done
}

main () {
  run_selected "$(select_scripts)"
}

main
