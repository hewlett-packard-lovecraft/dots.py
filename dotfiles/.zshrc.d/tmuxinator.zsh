# add tmuxinator aliases if installed

if (( ! $+commands[tmuxinator] )); then
  return 1
fi

alias mux="tmuxinator"
