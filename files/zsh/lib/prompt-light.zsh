source "$(dirname $0:A)/git_prompt.zsh"
ERROR_PROMPT='%(?,,%K{red}%F{white}%B %? %b%k)'
PROMPT='$ERROR_PROMPT$(git_prompt_info)%F{black}%K{white}%B %~ %b%k%f'
