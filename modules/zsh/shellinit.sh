# init all completions
autoload -U compinit
compinit

HIST_STAMPS="yyyy/mm/dd"

[ -d ".git" ] && onefetch
