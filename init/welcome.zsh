[[ -o interactive ]] &&
  [[ "$(tput lines)" -gt 40 ]] &&
  [[ "$(tput cols)" -gt 50 ]] &&
  _files=($HOME/.local/welcome/*.txt) &&
  cat "${_files[RANDOM % ${#_files[@]}]}" &&
  echo
