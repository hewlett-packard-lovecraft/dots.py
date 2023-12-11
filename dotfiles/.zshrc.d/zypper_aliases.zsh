# define aliases for zypper

# Return if requirements are not found.
if (( ! $+commands[zypper] )); then
  return 1
fi


#
# Aliases
#

alias zyp='sudo zypper'
