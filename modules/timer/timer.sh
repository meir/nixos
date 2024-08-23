#!/bin/bash

ask_prompt() {
  rofi -dmenu -p "Start timer" -lines 0
}

view() {
  times=$(t display | awk '{print $7}')
  labels=$(t display | sed -re 's,\s+, ,g' | cut -d ' ' -f 9- )

  for i in $(seq 0 $((${#times[@]} - 1))); do
    if [[ "${times[$i]}" == "" ]]; then
      continue
    fi
       
    echo "${times[$i]} - ${labels[$i]}"
  done
}

# ---

toggle() {
  current=$(t now)
  if [[ $current == "" ]]; then
    name=$(ask_prompt)
    t in "$name"
  else
    t out
  fi
}

show_logs() {
  logs=$(view)
  echo $logs | rofi -dmenu --lines 1 -i -p "Logs"
}

case $1 in
  "toggle")
    toggle
    ;;
  "view")
    show_logs
    ;;
esac
