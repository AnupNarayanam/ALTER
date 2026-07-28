# ============================================================
# FISH — SHELL CONFIG
# ============================================================
# Spec: "Minimal. No giant prompt." Fish handles interactive
# ergonomics (autosuggestions, syntax highlighting) out of the
# box; the actual prompt content/appearance is delegated
# entirely to Starship so it stays defined in exactly one place.
# ============================================================

if status is-interactive
    set fish_greeting              # empty = disables the default fish welcome banner

    # Starship renders the prompt — see starship/starship.toml
    starship init fish | source

    # Minimal, readable syntax highlighting consistent with the
    # black/white/red palette rather than fish's rainbow default
    set -g fish_color_command      FFFFFF
    set -g fish_color_param        C7C7C7
    set -g fish_color_error        FF1F3D
    set -g fish_color_comment      8C8C8C
    set -g fish_color_selection    --background=B00020
    set -g fish_color_cwd          FF1F3D
end

# --- Aliases: kept short, only for genuinely frequent actions ---
alias ll='ls -lah'
alias gs='git status'
alias yz='yazi'
alias vim='nvim'
