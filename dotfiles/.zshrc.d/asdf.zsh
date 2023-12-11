# activate asdf if installed

if [ ! -d ~/.asdf/ ]; then
  return 1
else
    . "$HOME/.asdf/asdf.sh"
fi
