#!/bin/bash

# Dotfiles installation script
# This script creates symlinks from the home directory to the dotfiles repository

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Installing dotfiles from ${DOTFILES_DIR}${NC}"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    
    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"
    
    # Backup existing file if it exists and is not a symlink
    if [[ -e "$target" && ! -L "$target" ]]; then
        echo -e "${YELLOW}Backing up existing $target to $target.backup${NC}"
        mv "$target" "$target.backup"
    fi
    
    # Remove existing symlink
    if [[ -L "$target" ]]; then
        rm "$target"
    fi
    
    # Create new symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✓ Linked $source -> $target${NC}"
}

# Install shell configurations
echo -e "\n${GREEN}Installing shell configurations...${NC}"
create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"
create_symlink "$DOTFILES_DIR/shell/.bash_profile" "$HOME/.bash_profile"
create_symlink "$DOTFILES_DIR/shell/.p10k.zsh" "$HOME/.p10k.zsh"

# Install git configuration
echo -e "\n${GREEN}Installing git configuration...${NC}"
create_symlink "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"

# Install Neovim configuration
echo -e "\n${GREEN}Installing Neovim configuration...${NC}"
create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Install miscellaneous configurations
echo -e "\n${GREEN}Installing miscellaneous configurations...${NC}"
create_symlink "$DOTFILES_DIR/misc/.condarc" "$HOME/.condarc"
create_symlink "$DOTFILES_DIR/misc/.xonshrc" "$HOME/.xonshrc"
create_symlink "$DOTFILES_DIR/misc/.tcshrc" "$HOME/.tcshrc"

echo -e "\n${GREEN}✓ Dotfiles installation complete!${NC}"
echo -e "\n${YELLOW}Note: You may need to:${NC}"
echo -e "  1. Restart your terminal or run 'source ~/.zshrc'"
echo -e "  2. Install Oh My Zsh if not already installed"
echo -e "  3. Install Powerlevel10k theme if not already installed"
echo -e "  4. Install Neovim plugins by opening nvim and running :Lazy"
echo -e "  5. Install conda/anaconda if using the conda configuration"