#!/bin/bash

ask_prompt() {
  rofi -dmenu -p "Start timer" -lines 0
}

view() {
  logs=$(t display -r -f json | jq -c '
  def duration($finish; $start):
    def twodigits: "00" + tostring | .[-2:];
    [$finish, $start]
    | map(strptime("%Y-%m-%d %H:%M:%S") | mktime) # seconds
    | .[0] - .[1]
    | (. % 60 | twodigits) as $s
    | (((. / 60) % 60) | twodigits)  as $m
    | (./3600 | floor) as $h
    | "\($h):\($m):\($s)" ; 
  [.[] | { start: .start, duration: duration(.end; .start), note: .note }]')

  count=$(echo "$logs" | jq length)
  for i in $(seq 0 $((count - 1))); do
    echo "$logs" | jq -r ".[$i] | .start + \" - \" + .duration + \" - \" + .note"
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
  echo "$logs" | rofi -dmenu --lines 1 -i -p "Logs"
}

case $1 in
  "toggle")
    toggle
    ;;
  "view")
    show_logs
    ;;
esac
