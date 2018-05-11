function h () { history 0 | grep $1 } # find in history
function cdp() { cd $(i prj --top "$@") }
function mkcd() { mkdir -p "$@" && cd "$_"; } # create dir and step into
function f() { find . -iname "*$1*" ${@:2} } # find file
function r() { grep "$1" ${@:2} -R . } # find file containing
function source_if_exists() { [[ -f "$1" ]] && source "$1"; } # source only if file exists
