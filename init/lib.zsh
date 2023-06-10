may_source() # source file only if file exists
{
	[ -f "$1" ] && . "$1" || return 1
}

may_call() # execute file only if file exists
{
	[ -x "$1" ] && $1 || return 1
}

mkcd() # create directory and step into
{
	mkdir -p "$@" && cd "$@" || return 1
}

cdp() # cd to best matching project directory
{
	cd "$(list-projects --top "$@")" || return 1
}
