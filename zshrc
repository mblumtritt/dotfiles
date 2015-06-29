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

# directories
setopt auto_cd # Auto changes to a directory without typing cd.
setopt auto_pushd # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups # Do not store duplicates in the stack.
#setopt pushd_silent         # Do not print the directory stack after pushd or popd.
setopt extended_glob        # Use extended globbing syntax.

# jobs
setopt notify # Report status of background jobs immediately.

# env
export PS1='%~$ '
export GZIP=-9
export EDITOR=mate
export PATH="$HOME/bin:$HOME/.rbenv/bin:$PATH"
export AWS_ACCESS_KEY_ID=`~/.aws/key`
export AWS_SECRET_ACCESS_KEY=`~/.aws/secret`

# extensions
source ~/.aliases
source ~/.zsh/lib/fn.zsh
source ~/.zsh/lib/git.zsh
source ~/.zsh/lib/h.zsh
source ~/.zsh/lib/take.zsh
source ~/.zsh/lib/theme.zsh
source ~/.zsh/lib/wo.zsh

theme wezm+
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
