function h () { history 0 | grep $1 } # find in history
function mkcd() { mkdir -p "$@" && cd "$_"; } # create dir and step into
function f() { find . -iname "*$1*" ${@:2} } # find file
function r() { grep "$1" ${@:2} -R . } # find file containing
# function cdp() { cd $(i prj --top "$@") }
function source_if_exists() { [[ -f "$1" ]] && source "$1"; } # source only if file exists
function tr() { web-view "$(web-find --dict "$1")" | convert-html-txt | less } # lookup in GE/EN dictionary
function google() { open "$(web-find --google "$1")" } # Google search
function img() { open "$(web-find --image "$1")" } # Google image search
function vid() { open "$(web-find --video "$1")" } # YouTube image search
function wiki() { open "$(web-find --wikipedia "$1")" } # Wikipedia article search
function command_not_found_handler() { i "$@" }
