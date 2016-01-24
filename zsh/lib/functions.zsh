lsr () { ls **/*$1* } # ls subdirs
h () { history 0 | grep $1 } # find in history
take () { mkdir -p $1; cd $1 } # create dir and step into
theme () { source ~/.zsh/themes/$1.zsh-theme } # select a theme
gp () { security find-generic-password -l $1 -w | tr -d '\r\n' | pbcopy } # store password from key chain in clipboard
