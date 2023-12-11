#
# Defines Yay aliases.

# Return if requirements are not found.
if (( ! $+commands[yay] )); then
  return 1
fi

#
# Frontend
#

_yay_frontend='yay'
_yay_sudo=' '

#
# Aliases
#

# yay.
alias yy="${_yay_frontend}"

# Installs packages from repositories.
alias yyi="${_yay_sudo}${_yay_frontend} --sync"

# Installs packages from files.
alias yyI="${_yay_sudo}${_yay_frontend} --upgrade"

# Removes packages and unneeded dependencies.
alias yyx="${_yay_sudo}${_yay_frontend} --remove"

# Removes packages, their configuration, and unneeded dependencies.
alias yyX="${_yay_sudo}${_yay_frontend} --remove --nosave --recursive"

# Displays information about a package from the repositories.
alias yyq="${_yay_frontend} --sync --info"

# Displays information about a package from the local database.
alias yyQ="${_yay_frontend} --query --info"

# Searches for packages in the repositories.
alias yys="${_yay_frontend} --sync --search"

# Searches for packages in the local database.
alias yyS="${_yay_frontend} --query --search"

# Lists orphan packages.
alias yay-list-orphans="${_yay_sudo}${_yay_frontend} --query --deps --unrequired"

# Removes orphan packages.
alias yay-remove-orphans="${_yay_sudo}${_yay_frontend} --remove --recursive \$(${_yay_frontend} --quiet --query --deps --unrequired)"

# Synchronizes the local package and Arch Build System databases against the
# repositories using the asp tool.
if (( $+commands[asp] )); then
  alias yyu="${_yay_sudo}${_yay_frontend} --sync --refresh && sudo asp update"
else
  alias yyu="${_yay_sudo}${_yay_frontend} --sync --refresh"
fi

# Synchronizes the local package database against the repositories then
# upgrades outdated packages.
alias yyU="${_yay_sudo}${_yay_frontend} --sync --refresh --sysupgrade"

function aurget {
  local target_dir="$1"
  if [[ -n "$2" ]]; then
    target_dir="$2"
  fi
  git clone "https://aur.archlinux.org/$1" "$target_dir"
}

unset _yay_{frontend,sudo}
