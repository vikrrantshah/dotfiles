
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
