# Dotfiles

Personal configuration files for i3, i3status, Alacritty, and Neovim.

## Structure

Each tool has its config stored in a `.config/` subdirectory, matching system expectations.
Symlinks are created manually using a custom script.

## Contents

- **Neovim**: Lua-based config, plugin manager, modular structure
- **i3/i3status**: Tiling window manager and status bar configs
- **Alacritty**: Terminal emulator config in TOML

## Usage

1. Clone the repository
2. Run `link-dotfiles.sh` to install configs via symlinks
