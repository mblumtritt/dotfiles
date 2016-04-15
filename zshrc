# Mike's

# colors
autoload -U colors
colors
export LSCOLORS=dxfxcxdxbxegedabagacad
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

# directories
setopt auto_cd # Auto changes to a directory without typing cd.
setopt auto_pushd # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups # Do not store duplicates in the stack.
setopt pushd_silent # Do not print the directory stack after pushd or popd.
setopt extended_glob # Use extended globbing syntax.

# jobs
setopt notify # Report status of background jobs immediately.

# get help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# env
export LC_ALL=$LANG
export GZIP=-9
export PS1='%~$ '
export EDITOR=mate
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/opt/go/libexec/bin"

# extensions
source ~/.aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
source ~/.zsh/lib/functions.zsh
source ~/.zsh/lib/prompt.zsh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
  # I may overwrite some things...
export PATH="$HOME/bin:$PATH"
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh
[[ -f ~/.init.sh ]] && source ~/.init.sh
