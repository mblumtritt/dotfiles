# Mike's

# colors
autoload -U colors
colors
export LSCOLORS=dxfxcxdxbxegedabagacad
# export LSCOLORS=Gxfxcxdxbxegedabagacad
export CLICOLOR=1

# prompt
setopt prompt_subst
setopt prompt_percent
autoload -U promptinit
promptinit

# completion
autoload -U compinit
autoload -U complist
compinit
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'

# history
HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# env
export PS1='%~$ '
export GZIP=-9
export EDITOR=mate
export PATH="$HOME/bin:$HOME/.rbenv/bin:$PATH"

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# aws
export AWS_ACCESS_KEY_ID=`ruby -ryaml -e 'puts YAML.load_file(File.expand_path("~/.aws/config.yaml"))[:AWS_ACCESS_KEY_ID]'`
export AWS_SECRET_ACCESS_KEY=`ruby -ryaml -e 'puts YAML.load_file(File.expand_path("~/.aws/config.yaml"))[:AWS_SECRET_ACCESS_KEY]'`

PROMPT='%~ %% '
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
