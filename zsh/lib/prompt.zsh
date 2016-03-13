PROMPT='$(git_prompt_info) %(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}λ%{$reset_color%} '
RPROMPT='%{$fg[green]%}%~%{$reset_color%}'

MY_PROMPT_PREFIX=" %{$fg[blue]%}"
MY_PROMPT_SUFFIX="%{$reset_color%}"
MY_PROMPT_UNTRACKED="%{$fg[red]%} ☡ "
MY_PROMPT_MODIFIED="%{$fg[red]%} ⌘ "
MY_PROMPT_RENAMED="%{$fg[red]%} ❢ "
MY_PROMPT_DELETED="%{$fg[red]%} ⏏ "
MY_PROMPT_STASHED="%{$fg[yellow]%} ♲ "
MY_PROMPT_UNMERGED="%{$fg[red]%} ✗ "
MY_PROMPT_AHEAD="%{$fg_bold[red]%} → "
MY_PROMPT_BEHIND="%{$fg_bold[red]%} ← "
MY_PROMPT_DIVERGED="%{$fg_bold[red]%} ↔︎ "

function git_prompt_info() {
  local REF=$(command git symbolic-ref HEAD 2> /dev/null) || \
    $(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "$MY_PROMPT_PREFIX${REF#refs/heads/}$(git_prompt_status)$MY_PROMPT_SUFFIX"
}

function git_prompt_status() {
  local INDEX=$(command git status --porcelain -b 2> /dev/null)
  local STATUS=""
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    STATUS="$MY_PROMPT_UNTRACKED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^A  ' &> /dev/null); then
    STATUS="$MY_PROMPT_ADDED$STATUS"
  elif $(echo "$INDEX" | command grep '^M  ' &> /dev/null); then
    STATUS="$MY_PROMPT_ADDED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^ M ' &> /dev/null); then
    STATUS="$MY_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | command grep '^AM ' &> /dev/null); then
    STATUS="$MY_PROMPT_MODIFIED$STATUS"
  elif $(echo "$INDEX" | command grep '^ T ' &> /dev/null); then
    STATUS="$MY_PROMPT_MODIFIED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^R  ' &> /dev/null); then
    STATUS="$MY_PROMPT_RENAMED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^ D ' &> /dev/null); then
    STATUS="$MY_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | command grep '^D  ' &> /dev/null); then
    STATUS="$MY_PROMPT_DELETED$STATUS"
  elif $(echo "$INDEX" | command grep '^AD ' &> /dev/null); then
    STATUS="$MY_PROMPT_DELETED$STATUS"
  fi
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$MY_PROMPT_STASHED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^UU ' &> /dev/null); then
    STATUS="$MY_PROMPT_UNMERGED$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^## .*ahead' &> /dev/null); then
    STATUS="$MY_PROMPT_AHEAD$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^## .*behind' &> /dev/null); then
    STATUS="$MY_PROMPT_BEHIND$STATUS"
  fi
  if $(echo "$INDEX" | command grep '^## .*diverged' &> /dev/null); then
    STATUS="$MY_PROMPT_DIVERGED$STATUS"
  fi
  echo $STATUS
}
