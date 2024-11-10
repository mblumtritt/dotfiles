# find file
fn() { find . -iname "*$1*" "${@:2}" }

# find file containing
ff() { grep "$1" "${@:2}" -R . }

# create directory and step into
mkcd() { mkdir -p "$1" && cd "$1" || return 1 }

# find my command
\#()
{
	local cmd="$(select-file -i -s -f -x "$HOME/bin" -m "$1")"
	[ "$cmd" = "" ] && return 1
	[ $# -ne 0 ] && shift
	print -z "${cmd} $@"
}

_fmc()
{
	(( CURRENT == 2 )) && {
		local cmds=( $(select-file -s -f -x "$HOME/bin") )
		_describe 'command' cmds
	}
	return 0
}
compdef _fmc \#

# cd to best matching project directory
cdp()
{
	local dir="$(select-file -i -d -r "$HOME/prj/3rd" "$HOME/prj/ivx" "$HOME/prj/my" -m "$1")"
	[ "$dir" = "" ] && return 1
	cd "$dir"
}

# cd to best matching project directory and start IDE
cde() { cdp "$@" && $IDE . }

_cdp()
{
	(( CURRENT == 2 )) && {
		local dirs=( $(select-file -s -d -r "$HOME/prj/3rd" "$HOME/prj/ivx" "$HOME/prj/my") )
		_describe 'dir' dirs
	}
	return 0
}
compdef _cdp cdp cde

# export AWS related environment variables
aws-env() { source "$HOME/.local/dotfiles/init/aws-export" }

# renew AWS session
aws-renew() { "$HOME/.local/dotfiles/init/aws-renew" "$1" && aws-env }

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
gh()
{
	case "$1" in
	('')
		browse "$(git-url)"
	;;
	(b|branch)
		browse "$(git-url)/tree/$(git-branch-name)"
		;;
	(o|open)
		browse "$(git-url)/pull/$(git-branch-name)"
		;;
	(p|pulls)
		browse "$(git-url)/pulls"
		;;
	(n|new)
		browse "$(git-url)/pull/new/$(git-branch-name)"
		;;
	(-h|--help|help)
		echo "gh       : open repository
gh <name>: open branch <name>
gh branch: open current branch
gh new   : create pull request for current branch
gh open  : open pull request for current branch
gh pulls : open pull request index
"
		;;
	(*)
		browse "$(git-url)/tree/$1"
		;;
	esac
}

_gh()
{
	(( CURRENT == 2 )) && {
		local commands=(
			'branch:open current branch'
			'help:more help'
			'new:create pull request for current branch'
			'open:open pull request for current branch'
			'pulls:open pull request index'
		)
		_describe 'command' commands
	}
	return 0
}
compdef _gh gh

# lookup in GE/EN dictionary
@tr() { fetch-web "$(print-search-url --dict "$@")" | convert-html-text | less }

# set title of the current tab
title() { echo "\e]0;"$@"\a" }

# set title of the current window
wtitle() { echo "\e]2;"$@"\e\\" }

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
