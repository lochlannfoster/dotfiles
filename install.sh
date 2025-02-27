#!/bin/bash
# install.sh - A simple dotfiles installer
#
# This script creates symbolic links in your home directory for selected dotfiles
# from this repository. If a dotfile already exists, it backs it up to a timestamped
# backup folder so that you won't lose any previous configuration.
#
# To use, simply run:
#   ./install.sh
#
# Feel free to add or remove files from the FILES array as needed.

set -e  # Exit immediately if a command exits with a non-zero status

# Get the absolute path of the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Using dotfiles directory: $DOTFILES_DIR"

# Create a backup directory with a timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_DIR="$HOME/dotfiles_backup_$TIMESTAMP"
mkdir -p "$BACKUP_DIR"
echo "Existing dotfiles (if any) will be backed up to: $BACKUP_DIR"

# List the dotfiles you wish to symlink.
# Modify this list to match your repository's dotfiles.
FILES=(
    ".bashrc"
    ".vimrc"
    ".gitconfig"
    # Add more dotfiles here...
)

for file in "${FILES[@]}"; do
    SOURCE_FILE="$DOTFILES_DIR/$file"
    TARGET_FILE="$HOME/$file"

    # Check if the source file exists in the repository
    if [ ! -e "$SOURCE_FILE" ]; then
        echo "Warning: $SOURCE_FILE does not exist, skipping."
        continue
    fi

    # If a file or symlink already exists at the target, back it up
    if [ -e "$TARGET_FILE" ] || [ -L "$TARGET_FILE" ]; then
        if [ "$(readlink "$TARGET_FILE")" != "$SOURCE_FILE" ]; then
            echo "Backing up existing $TARGET_FILE to $BACKUP_DIR"
            mv "$TARGET_FILE" "$BACKUP_DIR/"
        fi
    fi

    # Create (or update) the symlink
    echo "Linking $SOURCE_FILE to $TARGET_FILE"
    ln -sf "$SOURCE_FILE" "$TARGET_FILE"
done

echo "All done! Your dotfiles have been installed."

