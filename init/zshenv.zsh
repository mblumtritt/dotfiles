# .zshenv.zsh
#
# global helper functions

try_call() {
  [ -x "$1" ] && $@ || return 1
}

try_source() {
  [ -r "$1" ] && . $@ || return 1
}

# Usage: indirect_expand PATH -> $PATH
indirect_expand() {
  env |sed -n "s/^$1=//p"
}

# Usage: path_remove /path/to/bin [PATH]
# Eg, to remove ~/bin from $PATH
#     path_remove ~/bin PATH
path_remove() {
  local IFS=':'
  local newpath
  local dir
  local var=${2:-PATH}
  # Bash has ${!var}, but this is not portable.
  for dir in $(indirect_expand "$var"); do
    IFS=''
    if [ "$dir" != "$1" ]
    then newpath=$newpath:$dir
    fi
  done
  export $var=${newpath#:}
}

# Usage: path_prepend /path/to/bin [PATH]
# Eg, to prepend ~/bin to $PATH
#     path_prepend ~/bin PATH
path_prepend() {
  # if the path is already in the variable,
  # remove it so we can move it to the front
  path_remove "$1" "$2"
  #[ -d "${1}" ] || return
  local var="${2:-PATH}"
  local value=$(indirect_expand "$var")
  export ${var}="${1}${value:+:${value}}"
}

# Usage: path_append /path/to/bin [PATH]
# Eg, to append ~/bin to $PATH
#     path_append ~/bin PATH
path_append() {
  path_remove "${1}" "${2}"
  #[ -d "${1}" ] || return
  local var=${2:-PATH}
  local value=$(indirect_expand "$var")
  export $var="${value:+${value}:}${1}"
}
