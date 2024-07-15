source $(which cdl-alias)

export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

# init all completions
autoload -U compinit
compinit

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

HIST_STAMPS="yyyy/mm/dd"

# Theme config
ZSH_THEME="spaceship"

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

[ -d ".git" ] && onefetch
