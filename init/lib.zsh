may_source() # source file only if file exists
{
	[ -f "$1" ] && . "$1"
}

mkcd() # create directory and step into
{
	mkdir -p "$@" && cd "$@" || exit 1
}

cdp() # cd to best matching project directory
{
	cd "$(list-projects --top "$@")" || exit 1
}
