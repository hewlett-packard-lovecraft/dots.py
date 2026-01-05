# all the aliases and envs

[ -f ~/.zshrc.d/bob.zsh ] && source ~/.zshrc.d/bob.zsh

if [ -f ~/.zshrc.d/cargo.zsh ]; then
    source ~/.zshrc.d/cargo.zsh
fi


if [ -x "$(command -v emacs)" ]; then
    alias ew='emacsclient -c'
    alias ewt='emacs -nw'
fi

if [ -d "/opt/texlive-installer/" ]; then
    export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
    export MANPATH=/usr/local/texlive/2025/texmf-dist/doc/man:$MANPATH
    export INFOPATH=/usr/local/texlive/2025/texmf-dist/doc/info:$INFOPATH
fi


[ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
  source "$EAT_SHELL_INTEGRATION_DIR/zsh"

. "$HOME/.cargo/env"
