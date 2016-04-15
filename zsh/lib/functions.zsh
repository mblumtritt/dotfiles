function lsr () { ls **/*$1* } # ls subdirs
function h () { history 0 | grep $1 } # find in history
function mkcd() { mkdir -p "$@" && cd "$_"; } # create dir and step into
function f() { find . -iname "*$1*" ${@:2} } # find file
function r() { grep "$1" ${@:2} -R . } # find file containing
function cdp() { cd $(i prj --top "$@") }
