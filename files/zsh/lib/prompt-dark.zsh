source "$(dirname $0:A)/git_prompt.zsh"
ERROR_PROMPT='%(?,,%K{red}%F{blavk}%B %? %b%k)'
PROMPT='$ERROR_PROMPT$(git_prompt_info)%F{white}%K{black}%B %~ %b%k%f'
