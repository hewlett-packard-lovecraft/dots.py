# add cargo binaries to path of cargo is installed

# Return if requirements are not found.
if (( ! $+commands[cargo] )); then
  return 1
fi

export PATH=$HOME/.cargo/bin/:$PATH

