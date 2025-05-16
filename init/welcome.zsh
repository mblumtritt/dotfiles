# TODO: move this to a welcome bin
{
	[[ "$(tput lines)" -gt 35 ]] && [[ "$(tput cols)" -gt 40 ]]
} && {
	cat $(find $HOME/.local/assets/apic/*.txt -type f | shuf -n 1) && echo
} || {
	date +"=== %Y-%m-%d, %H:%M: $(shuf -n 1 $HOME/.local/assets/patter.txt) ==="
}
