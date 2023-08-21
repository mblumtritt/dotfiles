# find in history
h() { history 0 | grep "$1"}

# find file
f() { find . -iname "*$1*" "${@:2}" }

# find file containing
ff() { grep "$1" "${@:2}" -R . }

# show path
dump-path() { print -l ${(s.:.)PATH} }

# create directory and step into
mkcd() { mkdir -p "$1" && cd "$1" || return 1 }

# list projects
lp() { list-projects "$@" | column -x }

# cd to best matching project directory
cdp()
{
	local path="$(list-projects "$1")"
	[ "$path" = "" ] && { >&2 echo "no matching project - $1" && return 1 }
	cd "$path"
}

# cd to best matching project directory
cde() { cdp "$1" && edit-text . || return 1 }

# completion for cdp
_cdp()
{
	local prjs=( $(list-projects --abbrev) )
	(( CURRENT == 2 )) && _describe -t prjs 'commands' prjs
	return 0
}
compdef _cdp cdp cde

# list commands
lc() { list-commands "$@" | column -x }

# export AWS related environment variables
aws-env()
{
	source "$HOME/.local/dotfiles/init/aws-export"
}

# renew AWS session
aws-renew()
{
	"$HOME/.local/dotfiles/init/aws-renew" "$1" && aws-env
}

# find and execute command with options
\#()
{
	[ $# = 0 ] && { list-commands | column -x && return 0 }
	local cmd="$(list-commands --long "$1")"
	[ "$cmd" = "" ] && { >&2 echo "no such command - $1" && return 1 }
	shift
	${cmd} $@
	return $?
}

# completion for #
_fae()
{
	local cmds=( $(list-commands --abbrev) )
	(( CURRENT == 2 )) && _describe -t cmds 'commands' cmds
	return 0
}
compdef _fae \#

# add new password to password-store
npass()
{
	[ $# = 0 ] && { >&2 echo "pass-name missing" && return 1 }
	local name="$1"
	shift
	{
		[ $# = 0 ] && { generate-password } || { echo "$@" }
	} | pass insert -e "$name"
}

# open prefered browser
browse() { open -a Safari "$@" }

# URL of current project
git-url() { echo ${$(git remote get-url origin)/.git/$nop} }

# current branch name
git-branch-name() { basename "$(git symbolic-ref HEAD)" }

# GitHub command
@gh()
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

# lookup in GE/EN dictionary
@tr() { fetch-web "$(print-search-url --dict "$@")" | convert-html-text | less }

# show random ASCII art
apic() { cat $(find $HOME/.local/apic/*.txt -type f | shuf -n 1) && echo }

# print welcome message
welcome()
{
	{
		[[ -o interactive ]] &&
		[[ "$(tput lines)" -gt 35 ]] &&
		[[ "$(tput cols)" -gt 50 ]]
	} && apic || date +"=== $(sekki), %d.%m.%Y, %H:%M ==="
	return 0
}
