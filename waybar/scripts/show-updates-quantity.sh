#!/bin/bash

FILE="/tmp/waybar-updates-count"

if [ -f "$FILE" ]; then
  COUNT=$(cat "$FILE")
  echo "{\"text\":\"$COUNT\", \"class\":\"pending\"}"
else
  echo "{\"text\":\"0\", \"class\":\"updated\"}"
fi
