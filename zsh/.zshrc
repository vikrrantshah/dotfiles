### Oh My Zsh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto

# Uncomment the following line if pasting URLs and other text is messed up.
DISABLE_MAGIC_FUNCTIONS="true"

plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
### Oh My Zsh

### Custom Aliases
alias ls="ls -la"
alias vim="nvim"
alias v="nvim ."
alias todocs="cd ~/Documents"
alias toproj="cd ~/Documents/Personal/Projects"
alias tosproj="cd ~/Documents/Personal/Side\ Projects/"
alias tolab="cd ~/Documents/Personal/lab/"
alias so-zrc="source ~/.zshrc"
alias tms="sh ~/tmux-sessionizer/main.sh"
alias szr="sh ~/.sessionizer/main.sh"
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
