#!/bin/bash

TIMER_FILE="/tmp/waybar_timer"
EDIT_FILE="/tmp/waybar_timer_edit"
EDITING_FILE="/tmp/waybar_timer_editing"

NOW=$(date +%s)
EDIT_TIMEOUT=3 # Sekunden, wie lange die Zeit nach Scroll sichtbar ist

[ ! -f "$EDIT_FILE" ] && echo 25 >"$EDIT_FILE"
MINUTES=$(cat "$EDIT_FILE")

if [ -f "$TIMER_FILE" ]; then
  TARGET=$(cat "$TIMER_FILE")
  DIFF=$((TARGET - NOW))

  if [ $DIFF -le 0 ]; then
    notify-send -u critical "Timer abgelaufen!"
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga &

    rm -f "$TIMER_FILE"
    echo '{"text":"","class":"idle"}'
  else
    printf '{"text":"%02d:%02d","class":"running"}\n' \
      $((DIFF / 60)) $((DIFF % 60))
  fi

else
  if [ -f "$EDITING_FILE" ]; then
    LAST_EDIT=$(cat "$EDITING_FILE")
    if [ $((NOW - LAST_EDIT)) -le $EDIT_TIMEOUT ]; then
      printf '{"text":"%02d:%02d","class":"editing"}\n' \
        "$MINUTES" 0
      exit 0
    fi
  fi

  # Default idle
  echo '{"text":"","class":"idle"}'
fi
