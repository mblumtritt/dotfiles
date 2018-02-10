source "$(dirname $0:A)/git_prompt.zsh"
ERROR_PROMPT='%(?,,%K{red}%B %? %b%k)'
PROMPT='$ERROR_PROMPT$(git_prompt_info)%K{black}%B %~ %b%k%F{black}⮀%f'
