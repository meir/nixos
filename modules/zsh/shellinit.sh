# init all completions
autoload -U compinit
compinit

HIST_STAMPS="yyyy/mm/dd"

spaceship_prechar() {
  spaceship::section "" "" " " ""
}

SPACESHIP_PROMPT_ORDER=(prechar dir char)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false

SPACESHIP_DIR_PREFIX=''
SPACESHIP_CHAR_SYMBOL='‣ '
SPACESHIP_USER_SHOW=false

[ -d ".git" ] && onefetch || fastfetch
