function h() # find in history
{
	history 0 | grep "$1"
}

function mkcd() # create directory and step into
{
	mkdir -p "$@" && cd "$_"
}

function f() # find file
{
	find . -iname "*$1*" "${@:2}"
}

function ff() # find file containing
{
	grep "$1" "${@:2}" -R .
}

function cdp() # cd to best matching project directory
{
	cd $(list-projects --top "$@")
}

function cde() # cd to best matching project directory
{
	cd $(list-projects --top "$@") && edit-text .
}

function source_if_exists() # source file only if file exists
{
	[[ -f "$1" ]] && source "$1"
}

function command_exists() # check if a command is avail
{
	command -v "$1" >/dev/null 2>&1
}

function @tr() # lookup in GE/EN dictionary
{
  fetch-web "$(print-search-url --dict $1)" | convert-html-text | less
}
