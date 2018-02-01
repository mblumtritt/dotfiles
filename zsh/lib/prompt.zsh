PROMPT='%K{black}%F{white} %~%f %F{yellow}$(git_prompt_info)%f$ERROR_PROMPT%k%F{black}⮀%f'
ERROR_PROMPT="%(?,, ⎮%B%F{white}%?%f%b⎮ )"
GIT_PROMPT_PREFIX=""
GIT_PROMPT_SUFFIX="" # "%{$reset_color%}"
GIT_PROMPT_UNTRACKED=" ☡ "
GIT_PROMPT_MODIFIED=" ⌘ "
GIT_PROMPT_RENAMED=" ❢ "
GIT_PROMPT_DELETED=" ⏏ "
GIT_PROMPT_STASHED=" ♲ "
GIT_PROMPT_UNMERGED=" ✗ "
GIT_PROMPT_AHEAD=" → "
GIT_PROMPT_BEHIND=" ← "
GIT_PROMPT_DIVERGED=" ↔︎ "

function git_prompt_info() {
	local REF=$(command git symbolic-ref HEAD 2> /dev/null) || \
	  $(command git rev-parse --short HEAD 2> /dev/null) || \
		return 0
	echo "$GIT_PROMPT_PREFIX${REF#refs/heads/}$(git_prompt_status)$GIT_PROMPT_SUFFIX"
}

function git_prompt_status() {
	local INDEX=$(command git status --porcelain -b 2> /dev/null)
	local STATUS=" "
	if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_UNTRACKED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^A  ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_ADDED$STATUS"
	elif $(echo "$INDEX" | command grep '^M  ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_ADDED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^ M ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_MODIFIED$STATUS"
	elif $(echo "$INDEX" | command grep '^AM ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_MODIFIED$STATUS"
	elif $(echo "$INDEX" | command grep '^ T ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_MODIFIED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^R  ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_RENAMED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^ D ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_DELETED$STATUS"
	elif $(echo "$INDEX" | command grep '^D  ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_DELETED$STATUS"
	elif $(echo "$INDEX" | command grep '^AD ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_DELETED$STATUS"
	fi
	if $(command git rev-parse --verify refs/stash >/dev/null 2>&1)
	then
	  STATUS="$GIT_PROMPT_STASHED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^UU ' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_UNMERGED$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^## .*ahead' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_AHEAD$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^## .*behind' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_BEHIND$STATUS"
	fi
	if $(echo "$INDEX" | command grep '^## .*diverged' &> /dev/null)
	then
	  STATUS="$GIT_PROMPT_DIVERGED$STATUS"
	fi
	echo $STATUS
}
