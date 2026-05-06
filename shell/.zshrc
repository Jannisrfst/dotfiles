# zoxide
eval "$(zoxide init zsh)"
alias cd="z"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"  # DISABLED - Using Starship instead

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

source $ZSH/oh-my-zsh.sh

# Java (OpenJDK 21)
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jannisreufsteck/.lmstudio/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Added by Windsurf
export PATH="/Users/jannisreufsteck/.codeium/windsurf/bin:$PATH"

# Created by `pipx` on 2025-05-20 18:26:40
export PATH="$PATH:/Users/jannisreufsteck/.local/bin"

# Yazi file manager function
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
  yazi --cwd-file="$tmp" "$@"
  local cwd="$(cat "$tmp")"
  rm -f "$tmp"
  if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd "$cwd"
  fi
}

[ -f "/Users/jannisreufsteck/.ghcup/env" ] && . "/Users/jannisreufsteck/.ghcup/env" # ghcup-env

# Initialize Starship prompt
eval "$(starship init zsh)"

# Added by Antigravity
export PATH="/Users/jannisreufsteck/.antigravity/antigravity/bin:$PATH"

# bun completions
[ -s "/Users/jannisreufsteck/.bun/_bun" ] && source "/Users/jannisreufsteck/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
