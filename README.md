# Dotfiles

My personal dotfiles for macOS, including shell configurations, git settings, Neovim setup, and more.

## What's Included

### Shell Configuration
- **Zsh** (`.zshrc`) - Main shell configuration with Oh My Zsh
- **Zsh Profile** (`.zprofile`) - Environment variables and PATH settings
- **Bash Profile** (`.bash_profile`) - Bash compatibility
- **Powerlevel10k** (`.p10k.zsh`) - Beautiful terminal theme configuration

### Development Tools
- **Git** (`.gitconfig`) - Git configuration with LFS support
- **Neovim** (`nvim/`) - Complete LazyVim setup with plugins:
  - Catppuccin theme
  - GitHub Copilot integration
  - Custom keymaps and options
  - Language-specific configurations

### Other Configurations
- **Conda** (`.condarc`) - Python environment management
- **Xonsh** (`.xonshrc`) - Python-powered shell
- **Tcsh** (`.tcshrc`) - C shell configuration

## Prerequisites

Before installing these dotfiles, make sure you have:

1. **Zsh** (usually pre-installed on macOS)
2. **Oh My Zsh** - Install with:
   ```bash
   sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```
3. **Powerlevel10k theme** - Install with:
   ```bash
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
   ```
4. **Neovim** - Install with:
   ```bash
   brew install neovim
   ```
5. **Git** (for version control)

## Installation

### Quick Install
```bash
git clone https://github.com/Jannisrfst/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

### Manual Installation
If you prefer to install manually:

```bash
# Clone the repository
git clone https://github.com/Jannisrfst/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Create symlinks for shell configurations
ln -sf ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/shell/.zprofile ~/.zprofile
ln -sf ~/.dotfiles/shell/.bash_profile ~/.bash_profile
ln -sf ~/.dotfiles/shell/.p10k.zsh ~/.p10k.zsh

# Create symlink for git configuration
ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig

# Create symlink for Neovim configuration
ln -sf ~/.dotfiles/nvim ~/.config/nvim

# Create symlinks for miscellaneous configurations
ln -sf ~/.dotfiles/misc/.condarc ~/.condarc
ln -sf ~/.dotfiles/misc/.xonshrc ~/.xonshrc
ln -sf ~/.dotfiles/misc/.tcshrc ~/.tcshrc
```

## Post-Installation

After installation:

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Configure Powerlevel10k** (if first time):
   ```bash
   p10k configure
   ```

3. **Install Neovim plugins**:
   - Open Neovim: `nvim`
   - Plugins will auto-install with LazyVim

4. **Install zsh plugins** (if not already installed):
   ```bash
   # zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   
   # zsh-syntax-highlighting
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

## Customization

### Shell
- Modify `shell/.zshrc` for zsh-specific configurations
- Edit `shell/.p10k.zsh` to customize the Powerlevel10k theme
- Update `shell/.zprofile` for environment variables

### Neovim
- Add custom plugins in `nvim/lua/plugins/`
- Modify keymaps in `nvim/lua/config/keymaps.lua`
- Adjust options in `nvim/lua/config/options.lua`

### Git
- Update `git/.gitconfig` with your personal information:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your.email@example.com"
  ```

## Backup

The install script automatically creates backups of existing configuration files with a `.backup` extension. You can find them in your home directory if you need to restore anything.

## Repository Structure

```
dotfiles/
├── git/                 # Git configuration
│   └── .gitconfig
├── nvim/               # Neovim configuration (LazyVim)
│   ├── init.lua
│   ├── lua/
│   │   ├── config/
│   │   └── plugins/
│   └── ...
├── shell/              # Shell configurations
│   ├── .bash_profile
│   ├── .p10k.zsh
│   ├── .zprofile
│   └── .zshrc
├── misc/               # Miscellaneous configurations
│   ├── .condarc
│   ├── .tcshrc
│   └── .xonshrc
├── .gitignore
├── install.sh          # Installation script
└── README.md           # This file
```

## License

Feel free to use these dotfiles as inspiration for your own setup!