#!/usr/bin/env bash
# ============================================================
# NETWORK TOGGLE
# ============================================================
# Clicking the waybar network module opens a rofi picker of
# available wifi networks via nmcli — avoids needing a full
# GUI network manager for the common case of switching wifi.
# ============================================================

networks=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | awk -F: '!seen[$1]++ && $1 != "" {printf "%s  (%s%%)\n", $1, $2}')

chosen=$(echo "$networks" | rofi -dmenu -i -p "Wi-Fi" -theme ~/.config/rofi/theme.rasi)
ssid=$(echo "$chosen" | sed 's/  (.*%)$//')

[ -z "$ssid" ] && exit 0

if nmcli -t -f SSID dev wifi list | grep -qx "$ssid" && nmcli -t -g NAME connection show | grep -qx "$ssid"; then
    nmcli connection up "$ssid"
else
    password=$(rofi -dmenu -password -p "Password for $ssid" -theme ~/.config/rofi/theme.rasi)
    nmcli dev wifi connect "$ssid" password "$password"
fi

notify-send "Network" "Connecting to $ssid"
