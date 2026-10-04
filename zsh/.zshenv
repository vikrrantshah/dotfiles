# sshd runs remote commands (mosh-server, `ssh host herdr`) as a non-login
# `zsh -c`, which skips .zprofile/.zshrc and so never sees Homebrew.
if [[ -n $SSH_CONNECTION && ! -o login && -d /opt/homebrew/bin ]]; then
  path=(/opt/homebrew/bin /opt/homebrew/sbin $path)
fi
