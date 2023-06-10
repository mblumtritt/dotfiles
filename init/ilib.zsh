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

\#() # find and execute command with options
{
	[ $# = 0 ] && { >&2 echo "command missing" && return 1 }
	IFS=$'\n' readonly array=($(list-commands "$1"))
	[ ${#array[@]} = 0 ] && { >&2 echo "no such command - $1" && return 1 }
	[ ${#array[@]} = 1 ] || {
		>&2 echo "too many matching commands - $1\nDid you mean one of these?"
		>&2 IFS=$'\n'; echo "${array[*]}" | column -x
		return 1
	}
	shift
	"$(list-commands --long "${array}")" $@
	return $?
}
