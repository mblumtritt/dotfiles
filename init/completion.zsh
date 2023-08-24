
compdef _gnu_generic print-ip
compdef _gnu_generic print-search-url
compdef _gnu_generic shorten-words

_cdp()
{
	(( CURRENT == 2 )) && {
		local prjs=( $(list-projects --abbrev) )
		_describe -t prjs 'commands' prjs
	}
	return 0
}
compdef _cdp cdp cde

_fae()
{
	(( CURRENT == 2 )) &&{
		local cmds=( $(list-commands --abbrev) )
		_describe -t cmds 'commands' cmds
	}
	return 0
}
compdef _fae \#

_gh()
{
	(( CURRENT == 2 )) &&{
		local -a commands
  	commands=(
    	'branch:open current branch'
    	'create:create a pull request for current branch'
    	'current:open pull request for current branch'
    	'index:open pull request index'
  	)
		_describe -t commands 'commands' commands
	}
	return 0
}
compdef _gh gh
