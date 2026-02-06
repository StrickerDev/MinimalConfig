#!/bin/bash

# Zählt Pacman Updates
PAC=$(checkupdates 2>/dev/null | wc -l)

# Zählt AUR Updates
AUR=$(paru -Qua 2>/dev/null | wc -l)

# Zählt Flatpak Updates
FP=$(flatpak remote-ls --updates 2>/dev/null | wc -l)

FINAL_COUNT=$((PAC + AUR + FP))
echo "$FINAL_COUNT" >/tmp/waybar-updates-count

pkill -RTMIN+1 waybar
