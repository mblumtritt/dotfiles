h() # find in history
{
	history 0 | grep "$1"
}

f() # find file
{
	find . -iname "*$1*" "${@:2}"
}

ff() # find file containing
{
	grep "$1" "${@:2}" -R .
}

cde() # cd to best matching project directory
{
	cd "$(list-projects --top "$@")" && edit-text .
}

@tr() # lookup in GE/EN dictionary
{
  fetch-web "$(print-search-url --dict "$@")" | convert-html-text | less
}
