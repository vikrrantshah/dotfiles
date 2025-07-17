### powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_CUSTOM="$HOME/.omz-custom"
### powerlevel10k

### Oh my zsh
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 15

DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR='nvim'

### Oh my zsh

# JAVA
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# React-Native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

### Custom Aliases
alias ls="ls -la"
alias vim="nvim"
alias todocs="cd ~/Documents"
alias toproj="cd ~/Documents/Personal/Projects"
alias tosproj="cd ~/Documents/Personal/Side\ Projects/"
alias tolab="cd ~/Documents/Personal/lab/"
alias tms="sh ~/tmux-sessionizer/main.sh"
alias lg="lazygit"
alias f="fzf -m --preview 'bat --color=always --style=numbers --line-range :500 {}'"
alias bat="bat --color=always --style=numbers --line-range :500"
### Custom Aliases

### NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
### NVM

### Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
### Go

# pnpm
export PNPM_HOME="/Users/vikrantshah/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Added by Windsurf
export PATH="/Users/vikrantshah/.codeium/windsurf/bin:$PATH"
