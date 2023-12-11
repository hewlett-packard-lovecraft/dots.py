# activate pyenv if installed

if [ ! -d ~/.pyenv/ ]; then
  return 1
else
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    if [[ -d ~/.pyenv/plugins/pyenv-virtualenv/  ||  -d /usr/share/pyenv/plugins/pyenv-virtualenv ]]; then
	eval "$(pyenv virtualenv-init -)"
    fi
fi

