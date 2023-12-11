# Defines esp-idf.py aliases.

#Return if requirements are not found.
if [ ! -d ~/esp/ ]; then
  return 1
else
    #export IDF_EXPORT_QUIET=1
    #eval '. $HOME/esp/esp-idf/export.sh'
fi

alias get_idf='. $HOME/esp/esp-idf/export.sh'
