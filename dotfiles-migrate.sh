#!/bin/bash

# Dotfiles migration script for setting up configuration files from a bare Git repository
# Usage: ./dotfiles-migrate.sh

set -e

# Hardcoded repository URLs
GIT_REPO_HTTPS="https://github.com/sim-maz/dotfiles"
GIT_REPO_SSH="git@github.com:sim-maz/dotfiles.git"
CONFIG_DIR="$HOME/.cfg"
BACKUP_DIR="$HOME/.config-backup"

echo "Starting dotfiles migration..."

# Step 1: Add the gitdf alias to shell config files
echo "Step 1: Adding gitdf alias to shell configuration files..."
ALIAS_LINE="alias gitdf='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'"

for rc_file in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc_file" ]; then
        if ! grep -q "alias gitdf=" "$rc_file"; then
            echo "$ALIAS_LINE" >> "$rc_file"
            echo "  - Added alias to $rc_file"
        else
            echo "  - Alias already exists in $rc_file"
        fi
    fi
done

# Step 2: Add .cfg to .gitignore
echo "Step 2: Adding .cfg to .gitignore..."
if [ -f "$HOME/.gitignore" ]; then
    if ! grep -q "^\.cfg$" "$HOME/.gitignore"; then
        echo ".cfg" >> "$HOME/.gitignore"
        echo "  - Added .cfg to .gitignore"
    else
        echo "  - .cfg already in .gitignore"
    fi
else
    echo ".cfg" > "$HOME/.gitignore"
    echo "  - Created .gitignore with .cfg entry"
fi

# Step 3: Clone dotfiles into bare repository
echo "Step 3: Cloning dotfiles into bare repository..."
if [ -d "$CONFIG_DIR" ]; then
    echo "  - Warning: $CONFIG_DIR already exists. Skipping clone."
    echo "  - Remove $CONFIG_DIR if you want to re-clone."
else
    # Try HTTPS first, then SSH if that fails
    echo "  - Attempting to clone via HTTPS..."
    if git clone --bare "$GIT_REPO_HTTPS" "$CONFIG_DIR" 2>/dev/null; then
        echo "  - Successfully cloned repository via HTTPS"
    else
        echo "  - HTTPS clone failed, trying SSH..."
        if git clone --bare "$GIT_REPO_SSH" "$CONFIG_DIR"; then
            echo "  - Successfully cloned repository via SSH"
        else
            echo "  - Failed to clone repository via both HTTPS and SSH"
            exit 1
        fi
    fi
fi

# Step 4: Define the alias in current shell scope
echo "Step 4: Defining gitdf alias in current shell..."
alias gitdf='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Step 5: Checkout the actual content
echo "Step 5: Checking out dotfiles..."
if gitdf checkout 2>&1; then
    echo "  - Checkout successful"
else
    echo "  - Checkout failed due to existing files"
    echo "Step 6: Backing up conflicting files..."
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    
    # Move conflicting files to backup
    gitdf checkout 2>&1 | egrep "\s+\." | awk '{print $1}' | while read -r file; do
        if [ -f "$HOME/$file" ] || [ -d "$HOME/$file" ]; then
            # Create parent directory structure in backup
            mkdir -p "$BACKUP_DIR/$(dirname "$file")"
            mv "$HOME/$file" "$BACKUP_DIR/$file"
            echo "  - Backed up: $file"
        fi
    done
    
    # Step 7: Re-run checkout
    echo "Step 7: Re-running checkout..."
    if gitdf checkout; then
        echo "  - Checkout successful"
    else
        echo "  - Checkout failed. Please resolve conflicts manually."
        exit 1
    fi
fi

# Step 8: Set showUntrackedFiles to no
echo "Step 8: Configuring repository settings..."
gitdf config --local status.showUntrackedFiles no
echo "  - Set showUntrackedFiles to no"

echo ""
echo "✓ Dotfiles migration complete!"
echo ""
echo "IMPORTANT: Run the following command to use 'gitdf' in your current shell:"
echo "  alias gitdf='/usr/bin/git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'"
echo ""
echo "Or restart your terminal to load the alias from your shell configuration."
if [ -d "$BACKUP_DIR" ]; then
    echo ""
    echo "Conflicting files were backed up to: $BACKUP_DIR"
fi
