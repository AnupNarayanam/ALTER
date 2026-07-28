#!/usr/bin/env bash
# ============================================================
# SCREENSHOT
# ============================================================
# Region-select screenshot, copied to clipboard AND saved to
# disk. Uses grim+slurp (standard Wayland screenshot tooling)
# rather than a heavier GUI screenshot app.
# ============================================================

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/alter_$(date +%Y-%m-%d_%H-%M-%S).png"

grim -g "$(slurp)" "$FILE" && \
wl-copy < "$FILE" && \
notify-send "Screenshot saved" "$FILE" -i "$FILE"
