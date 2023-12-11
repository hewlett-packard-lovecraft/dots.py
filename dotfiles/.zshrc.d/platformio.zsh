# add pio binaries to path if installed

if [ ! -d ~/.platformio/ ]; then
  return 1
else
    export PATH=$PATH:$HOME/.local/bin
    # export PATH=$PATH:$HOME/.platformio/penv/bin
fi
