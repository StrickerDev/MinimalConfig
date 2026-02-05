#!/bin/bash

LOCKFILE="/tmp/waybar-updates.lock"

# Prüfen, ob schon ein Skript läuft
if [ -e "$LOCKFILE" ] && kill -0 "$(cat $LOCKFILE)" 2>/dev/null; then
  exit 0
fi

# Lock setzen
echo $$ >"$LOCKFILE"

# Zählt Pacman Updates
PAC=$(checkupdates 2>/dev/null | wc -l)

# Zählt AUR Updates
AUR=$(paru -Qua 2>/dev/null | wc -l)

# Zählt Flatpak Updates
FP=$(flatpak remote-ls --updates 2>/dev/null | wc -l)

FINAL_COUNT=$((PAC + AUR + FP))
echo "$FINAL_COUNT" >/tmp/waybar-updates-count

rm -f "$LOCKFILE"
