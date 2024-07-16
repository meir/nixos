# init all completions
autoload -U compinit
compinit

HIST_STAMPS="yyyy/mm/dd"

spaceship_prechar() {
  spaceship::section "" "" " " ""
}

[ -d ".git" ] && onefetch || fastfetch
