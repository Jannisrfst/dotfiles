#!/bin/bash

# Dotfiles installation script using GNU Stow
# Usage: ./install.sh [package...]
# Without arguments, installs all packages.

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(shell git misc nvim ghostty)

if ! command -v stow &>/dev/null; then
    echo "GNU Stow not found. Install with: brew install stow"
    exit 1
fi

# Use provided packages or default to all
if [ $# -gt 0 ]; then
    PACKAGES=("$@")
fi

echo -e "${GREEN}Installing dotfiles from ${DOTFILES_DIR}${NC}"
echo -e "${YELLOW}Packages: ${PACKAGES[*]}${NC}\n"

# Back up any conflicting real files before stowing
for pkg in "${PACKAGES[@]}"; do
    while IFS= read -r -d '' src; do
        rel="${src#"$DOTFILES_DIR/$pkg/"}"
        target="$HOME/$rel"
        if [[ -e "$target" && ! -L "$target" ]]; then
            echo -e "${YELLOW}Backing up $target → $target.bak${NC}"
            mv "$target" "$target.bak"
        fi
    done < <(find "$DOTFILES_DIR/$pkg" -not -name '.stow-local-ignore' -type f -print0 2>/dev/null)
done

cd "$DOTFILES_DIR"
stow --target="$HOME" "${PACKAGES[@]}"

echo -e "\n${GREEN}✓ Dotfiles installed via stow${NC}"
echo -e "\n${YELLOW}Notes:${NC}"
echo -e "  • Uninstall a package:  stow -D <package>"
echo -e "  • Reinstall a package:  stow -R <package>"
echo -e "  • Dry-run:              stow --simulate <package>"
