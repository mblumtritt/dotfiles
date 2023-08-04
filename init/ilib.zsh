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

lc() # list commands
{
	list-commands "$@" | column -x
}

npass() # add new name/password pair to password store
{
	[ $# = 0 ] && { >&2 echo "pass-name missing" && return 1 }
	[ $# = 1 ] && { >&2 echo "name/id missing" && return 1 }
	echo "$2" | pass insert -e "$1/name"
	generate-password | pass insert -e "$1/pass"
}

@tr() # lookup in GE/EN dictionary
{
  fetch-web "$(print-search-url --dict "$@")" | convert-html-text | less
}

browse() # open prefered browser
{
	open -a /Applications/Safari.app $@
}

git_url() # URL of current project
{
	echo ${$(git remote get-url origin)/.git/$nop}
}

git_branch_name() # current branch name
{
	basename "$(git symbolic-ref HEAD)"
}

@gh() # GitHub command
{
	case "$1" in
	-h|--help)
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
	-b)
		browse "$(git_url)/tree/$(git_branch_name)"
		;;
	-pr)
		browse "$(git_url)/pulls"
		;;
	-pc)
		browse "$(git_url)/pull/$(git_branch_name)"
		;;
	-pn)
		browse "$(git_url)/pull/new/$(git_branch_name)"
		;;
	-px)
		browse "$(git_url)/pull/$2"
		;;
	'')
		browse "$(git_url)"
	;;
	*)
		browse "$(git_url)/tree/$1"
		;;
	esac
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
