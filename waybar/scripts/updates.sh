#!/bin/bash
if [ ! -f /tmp/waybar-updates-count ]; then
    echo "0" > /tmp/waybar-updates-count
fi

COUNT=$(cat /tmp/waybar-updates-count)

if [ "$COUNT" -gt 0 ]; then
    # JSON Ausgabe für Waybar (Text = Zahl, Class = für CSS Styling)
    echo "{\"text\":\"$COUNT\", \"class\":\"pending\"}"
else
    echo "{\"text\":\"0\", \"class\":\"updated\"}"
fi
