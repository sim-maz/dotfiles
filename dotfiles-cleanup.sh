#!/bin/bash

# Dotfiles cleanup script to reverse the migration process
# Usage: ./dotfiles-cleanup.sh

set -e

CONFIG_DIR="$HOME/.cfg"
BACKUP_DIR="$HOME/.config-backup"

echo "Starting dotfiles cleanup..."
echo "WARNING: This will remove the bare repository and undo configuration changes."
echo ""
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cleanup cancelled."
    exit 0
fi

# Step 1: Remove the bare repository
echo "Step 1: Removing bare repository..."
if [ -d "$CONFIG_DIR" ]; then
    rm -rf "$CONFIG_DIR"
    echo "  - Removed $CONFIG_DIR"
else
    echo "  - $CONFIG_DIR not found, skipping"
fi

# Step 2: Remove gitdf alias from shell config files
echo "Step 2: Removing gitdf alias from shell configuration files..."
ALIAS_PATTERN="alias gitdf="

for rc_file in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc_file" ]; then
        if grep -q "$ALIAS_PATTERN" "$rc_file"; then
            # Create a backup before modifying
            cp "$rc_file" "$rc_file.backup-$(date +%Y%m%d-%H%M%S)"
            # Remove lines containing the gitdf alias
            grep -v "$ALIAS_PATTERN" "$rc_file" > "$rc_file.tmp" && mv "$rc_file.tmp" "$rc_file"
            echo "  - Removed alias from $rc_file"
        else
            echo "  - No alias found in $rc_file"
        fi
    fi
done

# Step 3: Remove .cfg from .gitignore
echo "Step 3: Removing .cfg from .gitignore..."
if [ -f "$HOME/.gitignore" ]; then
    if grep -q "^\.cfg$" "$HOME/.gitignore"; then
        # Create a backup before modifying
        cp "$HOME/.gitignore" "$HOME/.gitignore.backup-$(date +%Y%m%d-%H%M%S)"
        # Remove the .cfg line
        grep -v "^\.cfg$" "$HOME/.gitignore" > "$HOME/.gitignore.tmp" && mv "$HOME/.gitignore.tmp" "$HOME/.gitignore"
        echo "  - Removed .cfg from .gitignore"
        
        # If .gitignore is now empty, optionally remove it
        if [ ! -s "$HOME/.gitignore" ]; then
            echo "  - .gitignore is now empty"
            read -p "    Remove empty .gitignore? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm "$HOME/.gitignore"
                echo "    - Removed empty .gitignore"
            fi
        fi
    else
        echo "  - .cfg not found in .gitignore"
    fi
else
    echo "  - .gitignore not found"
fi

# Step 4: Inform about backup directory
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "Step 4: Backup directory found at: $BACKUP_DIR"
    echo "  - This directory contains files that were backed up during migration"
    read -p "  - Do you want to remove the backup directory? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$BACKUP_DIR"
        echo "  - Removed backup directory"
    else
        echo "  - Keeping backup directory"
    fi
else
    echo "Step 4: No backup directory found"
fi

echo ""
echo "✓ Dotfiles cleanup complete!"
echo ""
echo "IMPORTANT: Restart your terminal or run the following to remove the alias from your current shell:"
echo "  unalias gitdf"
echo ""
echo "Configuration file backups were created with timestamp suffixes."
