#!/bin/bash

NAME="AT Translated Set 2 keyboard"
ID=$(xinput | grep "$NAME" | grep -E -o "[0-9]+" | tail -1)

detach() {
  xinput float $ID
}

attach() {
  xinput reattach $ID 3
}


