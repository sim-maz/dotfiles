# Dotfiles Management Scripts

A collection of scripts to manage your dotfiles using a bare Git repository approach.

## Quick Start

### Install Dotfiles

Download and run the migration script directly:

```bash
curl -fsSL https://raw.githubusercontent.com/sim-maz/dotfiles/main/dotfiles-migrate.sh | bash
```

Or download first, then run:

```bash
curl -fsSL -o ~/dotfiles-migrate.sh https://raw.githubusercontent.com/sim-maz/dotfiles/main/dotfiles-migrate.sh
chmod +x ~/dotfiles-migrate.sh
~/dotfiles-migrate.sh
```

### Remove Dotfiles

Download and run the cleanup script:

```bash
curl -fsSL -o ~/dotfiles-cleanup.sh https://raw.githubusercontent.com/sim-maz/dotfiles/main/dotfiles-cleanup.sh
chmod +x ~/dotfiles-cleanup.sh
~/dotfiles-cleanup.sh
```

## What the Migration Script Does

1. Adds a `gitdf` alias to your `.bashrc` and `.zshrc`
2. Adds `.cfg` to your `.gitignore`
3. Clones the dotfiles repository as a bare repo to `~/.cfg`
4. Checks out your dotfiles to your home directory
5. Backs up any conflicting files to `~/.config-backup`
6. Configures Git to hide untracked files

## Using `gitdf` to Manage Dotfiles

After installation, use the `gitdf` command instead of `git` to manage your dotfiles:

### Check Status
```bash
gitdf status
```

### Add Files
```bash
# Add a single file
gitdf add .vimrc

# Add multiple files
gitdf add .bashrc .zshrc .tmux.conf
```

### Commit Changes
```bash
gitdf commit -m "Update vim configuration"
```

### Push to Remote
```bash
gitdf push
```

### Pull Latest Changes
```bash
gitdf pull
```

### View History
```bash
gitdf log
```

### See Differences
```bash
# See all changes
gitdf diff

# See changes for a specific file
gitdf diff .vimrc
```

### Add New Files
```bash
# Stage a new dotfile
gitdf add .config/nvim/init.vim
gitdf commit -m "Add neovim config"
gitdf push
```

## Important Notes

- The `gitdf` alias works exactly like `git`, but it's specifically for your dotfiles
- Only files you explicitly add with `gitdf add` are tracked
- Untracked files in your home directory are hidden by default (won't clutter `gitdf status`)
- After installation, restart your terminal or run: `alias gitdf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'`

## What the Cleanup Script Does

1. Removes the `~/.cfg` bare repository
2. Removes the `gitdf` alias from shell configuration files
3. Removes `.cfg` from `.gitignore`
4. Optionally removes the backup directory
5. Creates timestamped backups of modified configuration files

## Troubleshooting

### Alias not found after installation
Restart your terminal or manually run:
```bash
alias gitdf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

### Conflicts during installation
Conflicting files are automatically backed up to `~/.config-backup`. Review and merge them as needed.

### Clone fails
The script tries HTTPS first, then falls back to SSH. Ensure you have:
- Internet connectivity
- SSH keys configured for GitHub (if HTTPS fails)
