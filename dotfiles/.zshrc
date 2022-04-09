# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/haoming/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="macovsky"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
 alias zshconfig="source ~/.zshrc"
 alias ohmyzsh="source ~/.oh-my-zsh"

alias sdnf='sudo dnf'
alias svim='sudo nvim'
alias vim='nvim'
alias vi='vim'
alias s='sudo'
alias u='sudo dnf upgrade -y --refresh && sudo flatpak update -y'
alias pdf='pandoc -s -o'
alias njs-project='npx license mit && npx gitignore node && npx covgen contact@haomigxia.xyz && npm init -y'

alias cler="espeak 'fuck you'"
alias clar="espeak 'fuck you'"
alias claer="espeak 'fuck you'"

alias noed="espeak 'fuck you'"
alias ndoe="espeak 'fuck you'"
alias neod="espeak 'fuck you'"

alias gti="espeak 'fuck you'"
alias tgi="espeak 'fuck you'"
alias tig="espeak 'fuck you'"

alias suod="espeak 'fuck you'"
alias sduo="espeak 'fuck you'"
alias sodu="espeak 'fuck you'"

alias vmi="espeak 'fuck you'"
alias svin="espeak 'fuck you'"
alias svmi="espeak 'fuck you'"

alias laptopmode="sudo egpu-switcher switch internal"
alias egpumode="sudo egpu-switcher switch auto"

alias mux='tmux new -A -s ${USER}'

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

export PATH=/home/haoming/.local/bin:$PATH

source ~/antigen.zsh
antigen use oh-my-zsh

# plugins with oh-my-zsh
antigen bundle git
antigen bundle command-not-found
antigen bundle common-aliases

antigen bundle autojump
antigen bundle z
antigen bundle fasd

# Set the default plugin repo to be zsh-utils
antigen use belak/zsh-utils

# Specify completions we want before the completion module
antigen bundle zsh-users/zsh-completions

# Specify plugins we want
antigen bundle editor
antigen bundle history
antigen bundle prompt
antigen bundle utility
antigen bundle completion
# external plugins
antigen bundle unixorn/git-extra-commands
antigen bundle psprint/zsh-navigation-tools
antigen bundle desyncr/auto-ls
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting # must be last plugin to get effect

# theme
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=white'

# apply config
antigen apply

# map alt + hjkl to arrow keys using xmodmap
setxkbmap -layout us -variant altgr-intl -option nodeadkeys
xmodmap -e "keycode 43 = h H NoSymbol NoSymbol Left   NoSymbol"
xmodmap -e "keycode 44 = j J NoSymbol NoSymbol Down   NoSymbol"
xmodmap -e "keycode 45 = k K NoSymbol NoSymbol Up     NoSymbol"
xmodmap -e "keycode 46 = l L NoSymbol NoSymbol Right  NoSymbol"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)
