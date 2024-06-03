# activate pyenv if installed

if (( ! $+commands[rsync] )); then
  return 1
fi

alias mux="tmuxinator"
