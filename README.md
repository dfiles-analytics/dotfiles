# Dotfiles

Personal configuration files for my development environment, managed with symlinks.

## Structure

```
dotfiles/
├── config-files/
│   ├── alacritty/
│   ├── i3/
│   ├── i3status/
│   ├── nvim/
│   ├── tmux/
│   ├── .tmux.conf
│   └── .zshrc
├── link-dotfiles.sh
└── link.list
```

## Symlink Management

Dotfiles are symlinked into place using the `link-dotfiles.sh` script.

### Creating symlinks

```bash
./link-dotfiles.sh
```

This reads `link.list` and creates symlinks from your repo to `$HOME`.

### Dry-run

To preview what the script will do:

```bash
./link-dotfiles.sh --dry-run
```

## Add/Edit a dotfile

1. Place the config file in the corresponding subfolder in the repo.
2. Add an entry in `link.list`, e.g.:

   ```
   alacritty = ~/.config/alacritty
   ```

3. Run the script again to apply the change.

## Requirements

- GNU coreutils (`ln`, `xargs`, etc.)

## Security

Sensitive files like `~/.ssh` or `~/.gnupg` are not versioned and should be backed up separately.

## Notes

- Only symlinks are created, no original files are deleted.
- Existing links are forcefully replaced.
