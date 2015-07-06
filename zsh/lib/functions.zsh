fn() { ls **/*$1* } # ls subdirs
h () { history 0 | grep $1 } # find in history
o () { if [ $# -eq 0 ]; then open .; else open "$@"; fi; } # open
take () { mkdir -p $1; cd $1 } # create dir and step into
theme () { source ~/.zsh/themes/$1.zsh-theme } # select a theme
wo () { curl http://find/clients.txt 2>/dev/null | awk '{print $1, "\t" $3}' | grep -i "$@" | expand -t30} # find someone
