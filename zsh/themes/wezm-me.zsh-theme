PROMPT='$(git_prompt_info) %(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}λ%{$reset_color%} '
RPROMPT='%{$fg[green]%}%~%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="-"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%} ☡ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%} ⌘ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%} ❢ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ⏏ "
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[yellow]%} ♲ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%} ✗ "
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[red]%} → "
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[red]%} ← "
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg_bold[red]%} ↔︎ "
