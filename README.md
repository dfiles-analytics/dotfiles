# Dotfiles

Personal configuration files for my development environment, managed with symlinks.

## Structure

This repository mirrors the structure of `$HOME/.config` and related files. Each tool has its own subfolder:

```
dotfiles/
├── alacritty/
├── i3/
├── i3status/
├── nvim/
├── tmux/
│   └── .tmux.conf
├── link-dotfiles.sh
└── link.conf
```

## Symlink Management

Dotfiles are symlinked into place using the `link-dotfiles.sh` script.

### Creating symlinks

```bash
./link-dotfiles.sh
```

This reads `link.conf` and creates symlinks from your repo to `$HOME`.

### Dry-run

To preview what the script will do:

```bash
./link-dotfiles.sh --dry-run
```

### Optional unlink script

(Coming soon) – to remove symlinks cleanly based on `link.conf`.

## Add/Edit a dotfile

1. Place the config file in the corresponding subfolder in the repo.
2. Add an entry in `link.conf`, e.g.:

   ```
   alacritty = ~/.config/alacritty
   ```

3. Run the script again to apply the change.

## Requirements

- Bash
- GNU coreutils (`ln`, `xargs`, etc.)

## Security

Sensitive files like `~/.ssh` or `~/.gnupg` are not versioned and should be backed up separately.

## Notes

- Only symlinks are created, no original files are deleted.
- Existing links are forcefully replaced (`ln -sf`).
