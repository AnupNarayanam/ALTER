# Alter

A handcrafted Hyprland desktop environment built for a terminal-first
cybersecurity/software engineering workflow. No RGB, no rice, no decoration
without a reason.

Alter ships with **Obsidian Red** as its default color palette — black,
white, and crimson red only. The palette is swappable in principle (see
**Changing the palette** below), but Obsidian Red is the palette this
repository is built and tuned around.

## Requirements

Arch Linux (or an Arch-based distro) is assumed. Install these before running
`install.sh`:

```bash
sudo pacman -S hyprland waybar kitty fish starship rofi hyprlock hypridle \
    hyprpaper swaync yazi fastfetch grim slurp wl-clipboard networkmanager \
    ttf-jetbrains-mono-nerd papirus-icon-theme polkit-kde-agent brightnessctl
```

Inter font: install `ttf-inter` from your distro repos, or it will be picked
up automatically from `assets/fonts/Inter/` once you drop the `.ttf`/`.otf`
files there (not bundled in this repo — see **Fonts** below).

Bibata cursor theme:
```bash
yay -S bibata-cursor-theme     # AUR, if using an AUR helper
```

## Install

```bash
git clone [https://github.com/AnupNarayanam/ALTER/](ALTER) alter
cd alter
chmod +x install.sh update.sh uninstall.sh
./install.sh
```

This will:
- Check for missing dependencies (warns, doesn't hard-block)
- **Back up** any existing configs it would overwrite to `~/.config-backup-<timestamp>/`
- Symlink every module (`hypr/`, `waybar/`, `kitty/`, etc.) into `~/.config/`
- Regenerate `hypr/conf/colors.conf` from the master `assets/themes/colors.conf`
- Install fonts to `~/.local/share/fonts/`
- Link GTK theme settings

Log out and back into Hyprland (or reboot) afterward.

## Update

```bash
./update.sh
```

Pulls the latest repo changes (if this is a git checkout) and re-runs the
install step so colors and any new modules stay in sync.

## Uninstall

```bash
./uninstall.sh
```

Removes the symlinks and offers to restore your most recent pre-install
backup.

## Changing the palette

Edit **one file**: `assets/themes/colors.conf`. Every hex value in the whole
desktop traces back to this file. After editing, run `./install.sh` again —
it regenerates `hypr/conf/colors.conf` and everything else (waybar CSS,
rofi/swaync theming) reads the same tokens directly.

## Wallpapers

Drop your own images into `assets/wallpapers/`:
- `default.png` — main desktop wallpaper
- `lockscreen.png` — used by Hyprlock (gets blurred per config, so it can be
  the same image as `default.png` or a variant)

Spec direction: minimal, mostly black, small geometric red elements. No
placeholder images are bundled — add your own to match your monitor's
resolution.

## Keybinds (defaults)

| Key | Action |
|---|---|
| `Super + Return` | Open terminal (kitty) |
| `Super + Space` | Launcher (rofi) |
| `Super + E` | File manager (yazi in kitty) |
| `Super + Q` | Close focused window |
| `Super + Shift + Q` | Exit Hyprland session |
| `Super + L` | Lock screen |
| `Super + Shift + P` | Power menu |
| `Super + N` | Toggle notification center |
| `Super + H/J/K/L` | Move focus |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + 1-0` | Switch workspace |
| `Print` | Screenshot (region select) |

Full list in `hypr/conf/keybinds.conf`.

## Structure

```
alter/
├── install.sh / update.sh / uninstall.sh
├── assets/themes/colors.conf   ← single source of truth for the palette
├── hypr/                        ← compositor config (modular, see conf/)
├── waybar/                      ← status bar (3-zone layout)
├── kitty/ fish/ starship/       ← terminal stack
├── rofi/                        ← launcher
├── hyprlock/ hypridle/ hyprpaper/  ← lock/idle/wallpaper
├── swaync/                      ← notifications
├── gtk/ qt/                     ← app theme consistency
├── fastfetch/ yazi/             ← system info card / file manager
└── scripts/                     ← power menu, screenshot, network toggle
```

Every module is independent and can be edited or disabled without touching
the others — nothing here is monolithic.
