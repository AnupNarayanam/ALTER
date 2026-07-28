#!/usr/bin/env bash
# ============================================================
# ALTER — UNINSTALL
# ============================================================
# Removes the symlinks created by install.sh and, if a backup
# from a previous install exists, offers to restore it.
# ============================================================
set -euo pipefail

CONFIG_DIR="$HOME/.config"
MODULES=(hypr waybar kitty fish starship rofi hyprlock hypridle hyprpaper swaync gtk qt fastfetch yazi assets scripts)

echo "== Alter uninstall =="

for mod in "${MODULES[@]}"; do
    if [ -L "$CONFIG_DIR/$mod" ]; then
        rm "$CONFIG_DIR/$mod"
        echo "Removed symlink: $mod"
    fi
done

LATEST_BACKUP=$(ls -d "$HOME"/.config-backup-* 2>/dev/null | sort | tail -n1 || true)

if [ -n "$LATEST_BACKUP" ]; then
    read -rp "Found backup at $LATEST_BACKUP — restore it? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        for mod in "${MODULES[@]}"; do
            [ -e "$LATEST_BACKUP/$mod" ] && cp -r "$LATEST_BACKUP/$mod" "$CONFIG_DIR/"
        done
        echo "Restored previous configs from $LATEST_BACKUP"
    fi
else
    echo "No previous backup found — configs left removed."
fi

echo "== Uninstall complete =="
echo "Log out and select a different session/DE if Hyprland is no longer wanted."
