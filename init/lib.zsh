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

dump-path() # show path
{
	print -l ${(s.:.)PATH}
}

mkcd() # create directory and step into
{
	mkdir -p "$1" && cd "$1" || return 1
}

lp() # list projects
{
	list-projects "$@" | column -x
}

cdp() # cd to best matching project directory
{
	local path="$(list-projects "$1")"
	[ "$path" = "" ] && { >&2 echo "no matching project - $1" && return 1 }
	cd "$path"
}

cde() # cd to best matching project directory
{
	cdp "$1" && edit-text . || return 1
}

lc() # list commands
{
	list-commands "$@" | column -x
}

\#() # find and execute command with options
{
	[ $# = 0 ] && { list-commands | column -x && return 0 }
	local cmd="$(list-commands --long "$1")"
	[ "$cmd" = "" ] && { >&2 echo "no such command - $1" && return 1 }
	shift
	${cmd} $@
	return $?
}

fae_completion() {
	readonly cmds=( $(list-commands) )
	compadd -a cmds
}
compdef fae_completion \#

npass() # add new password to password-store
{
	[ $# = 0 ] && { >&2 echo "pass-name missing" && return 1 }
	readonly name="$1"
	shift
	{
		[ $# = 0 ] && { generate-password } || { echo "$@" }
	} | pass insert -e "$name"
}

browse() # open prefered browser
{
	open -a Safari "$@"
}

git-url() # URL of current project
{
	echo ${$(git remote get-url origin)/.git/$nop}
}

git-branch-name() # current branch name
{
	basename "$(git symbolic-ref HEAD)"
}

@gh() # GitHub command
{
	case "$1" in
	(-h|--help)
		cat <<- HELP
			Options:
			<name>   open branch <name>
			-b       open current branch
			-pr      open pull requests
			-pc      open pull request for current branch
			-pn      create pull request for current branch
			-px      open pull request #x
		HELP
		;;
	(-b)
		browse "$(git-url)/tree/$(git-branch-name)"
		;;
	(-pr)
		browse "$(git-url)/pulls"
		;;
	(-pc)
		browse "$(git-url)/pull/$(git-branch-name)"
		;;
	(-pn)
		browse "$(git-url)/pull/new/$(git-branch-name)"
		;;
	(-px)
		browse "$(git-url)/pull/$2"
		;;
	('')
		browse "$(git-url)"
	;;
	(*)
		browse "$(git-url)/tree/$1"
		;;
	esac
}

@tr() # lookup in GE/EN dictionary
{
  fetch-web "$(print-search-url --dict "$@")" | convert-html-text | less
}

welcome() # print file content found in welcome dir
{
	[[ -o interactive ]] &&
		[[ "$(tput lines)" -gt 35 ]] &&
		[[ "$(tput cols)" -gt 50 ]] &&
		cat $(find $HOME/.local/welcome/*.txt -type f | shuf -n 1) &&
		echo
	return 0
}
