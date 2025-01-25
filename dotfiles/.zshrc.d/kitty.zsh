# enable aliases for kitty if kitty is installed

# Return if requirements are not found.
if (( ! $+commands[kitty] )); then
  return 1
fi

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"


