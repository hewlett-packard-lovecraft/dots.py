# add nvim to path of bob version manager is installed

# Return if requirements are not found.
if (( ! $+commands[bob] )); then
  return 1
fi

export PATH=$HOME/.local/share/bob/nvim-bin/:$PATH
