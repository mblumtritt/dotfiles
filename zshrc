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
HISTSIZE=444
SAVEHIST=111
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# cd & Co.
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
# setopt extended_glob

# jobs
setopt notify

# get help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# env
export LC_ALL=$LANG
export GZIP=-9
export PS1='%~$ '
export EDITOR=atom
export EDITOR=mate
export GOPATH=$HOME/prj/go
export PATH="/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/opt/go/libexec/bin"
export RACK_ENV=development

# allow to search trough history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

# extensions
source ~/.aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
source ~/.zsh/lib/functions.zsh
source ~/.zsh/lib/prompt.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which exenv > /dev/null; then eval "$(exenv init -)"; fi
  # I want overwrite some things...
export PATH="$HOME/bin:$PATH"
[[ -f ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh<
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
