#
# Defines dpkg aliases.
#
# Authors:
#   Daniel Bolton <dbb@9y.com>
#   Benjamin Boudreau <boudreau.benjamin@gmail.com>
#   Sorin Ionescu <sorin.ionescu@gmail.com>
# https://github.com/sorin-ionescu/prezto/blob/master/modules/dpkg/README.md

# ## Aliases
#
# - `debc` cleans the cache.
# - `debf` displays a file's package.
# - `debi` installs packages from repositories.
# - `debI` installs packages from files.
# - `debq` displays package information.
# - `debu` updates the package lists.
# - `debU` upgrades outdated packages.
# - `debx` removes packages.
# - `debX` removes packages, their configuration, and unneeded dependencies.
# - `debs` searches for packages.
# - `deb-build` creates a basic deb package.
# - `deb-kclean` removes all kernel images and headers, except for the ones in
#   use.
#
# ## Functions
#
# - `deb-clone` generates a script that can be used to duplicate a `dpkg`-based
#   system.
# - `deb-history` displays `dpkg` history.
# - `deb-kbuild` makes a `dpkg` Linux kernel package.

# Return if requirements are not found.
if (( ! $+commands[dpkg] && ! $+commands[apt-get] )); then
  return 1
fi

#
# Aliases
#

# Cleans the cache.
alias debc='sudo apt-get clean && sudo apt-get autoclean'

# Displays a file's package.
alias debf='apt-file search --regexp'

# Installs packages from repositories.
alias debi='sudo apt-get install'

# Installs packages from files.
alias debI='sudo dpkg -i'

# Displays package information.
alias debq='apt-cache show'

# Updates the package lists.
alias debu='sudo apt-get update'

# Upgrades outdated packages.
alias debU='sudo apt-get update && sudo apt-get dist-upgrade'

# Removes packages.
alias debx='sudo apt-get remove'

# Removes packages, their configuration, and unneeded dependencies.
alias debX='sudo apt-get remove --purge && sudo apt-get autoremove --purge'

# Searches for packages.
if (( $+commands[aptitude] )); then
  alias debs='aptitude -F "* %p -> %d \n(%v/%V)" --no-gui --disable-columns search'
else
  alias debs='apt-cache search'
fi

# Creates a basic deb package.
alias deb-build='time dpkg-buildpackage -rfakeroot -us -uc'

# Removes all kernel images and headers, except for the ones in use.
alias deb-kclean='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea) ?not(~n$(uname -r)))"'
