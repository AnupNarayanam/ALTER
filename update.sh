#!/usr/bin/env bash
# ============================================================
# ALTER — UPDATE
# ============================================================
# Since every module is symlinked (not copied) by install.sh,
# updating just means pulling the latest repo changes and
# re-running the color-token regeneration step. Symlinks
# themselves don't need to be recreated unless a NEW module
# directory was added since your last install.
# ============================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "== Alter update =="

if [ -d .git ]; then
    echo "Pulling latest changes..."
    git pull
else
    echo "Not a git checkout — skipping pull. Manually update repo files, then re-run this script."
fi

# Re-run install.sh so any new modules get linked and colors.conf
# stays regenerated from the master token file.
bash "$REPO_DIR/install.sh"

echo "== Update complete =="
echo "Reload Hyprland (SUPER+SHIFT+Q won't reload config — use: hyprctl reload) or log out/in."
