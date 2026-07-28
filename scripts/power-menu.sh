#!/usr/bin/env bash
# ============================================================
# POWER MENU
# ============================================================
# Simple rofi-driven power menu — kept as a script rather than
# a rofi mode so the same logic can be triggered by a keybind
# or a waybar click without duplicating config.
# ============================================================

options="Lock\nSuspend\nReboot\nShutdown\nLogout"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/theme.rasi)

case "$chosen" in
    "Lock")     hyprlock ;;
    "Suspend")  systemctl suspend ;;
    "Reboot")   systemctl reboot ;;
    "Shutdown") systemctl poweroff ;;
    "Logout")   hyprctl dispatch exit ;;
    *) exit 0 ;;
esac
