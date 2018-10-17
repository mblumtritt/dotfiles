function h () # find in history
{ history 0 | grep $1 }

function mkcd() # create directory and step into
{ mkdir -p "$@" && cd "$_"; }

function f() # find file
{ find . -iname "*$1*" ${@:2} }

function r() # find file containing
{ grep "$1" ${@:2} -R . }

function cdp() # cd to best matching project directory
{ cd $(project-find --top "$@") }

function source_if_exists() # source file only if file exists
{ [[ -f "$1" ]] && source "$1"; }

function tr() # lookup in GE/EN dictionary
{ web-view "$(web-find --dict "$1")" | html-convert-txt | less }

function google() # Google search
{ open "$(web-find --google "$1")" }

function img() # Google image search
{ open "$(web-find --image "$1")" }

function vid() # YouTube image search
{ open "$(web-find --video "$1")" }

function wiki() # Wikipedia article search
{ open "$(web-find --wikipedia "$1")" }

function e() # edit given file or best matching project
{
	if [ -e "$1" ]
	then
		mate "$1"
	else
		mate "$(project-find --top "$1")"
	fi
}

function command_not_found_handler() # handler for invalid commands
{ i "$@" }
