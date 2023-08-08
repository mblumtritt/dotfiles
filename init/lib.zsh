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
	mkdir -p "$@" && cd "$@" || return 1
}

cdp() # cd to best matching project directory
{
	cd "$(list-projects --top "$@")" || return 1
}

cde() # cd to best matching project directory
{
	cd "$(list-projects --top "$@")" && edit-text .
}

lc() # list commands
{
	list-commands "$@" | column -x
}

\#() # find and execute command with options
{
	[ $# = 0 ] && { >&2 echo "command missing" && return 1 }
	IFS=$'\n' readonly cmds=($(list-commands "$1"))
	[ ${#cmds[@]} = 0 ] && { >&2 echo "no such command - $1" && return 1 }
	[ ${#cmds[@]} = 1 ] || {
		>&2 echo "too many matching commands - $1\nDid you mean one of these?"
		>&2 IFS=$'\n'; echo "${cmds[*]}" | column -x
		return 1
	}
	shift
	${cmds} $@
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
	open -a /Applications/Safari.app $@
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
}
