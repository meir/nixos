# ignore errors on the rest of the file
c = c
config = config

config.load_autoconfig()

c.auto_save.session = True
c.url.searchengines = {
  "DEFAULT": "https://www.google.com/search?q={}",
}

c.tabs.background = True
c.tabs.select_on_remove = "prev"
c.tabs.new_position.unrelated = "next"
c.tabs.position = "left"
c.tabs.mousewheel_switching = False

c.content.autoplay = False
c.content.javascript.clipboard = "access"

c.hints.selectors["all"] += [
    "[aria-haspopup]",
]

# keybindings

config.bind('pi', 'spawn xdotool key space ;; spawn --userscript pinp {url}')
config.bind('tt', 'config-cycle tabs.show always switching')

bg = "#101A0B"
fg = "#F7F4F3"
contrast_low = "#131711"
contrast_high = "#D1496B"
accent = "#10A070"

c.tabs.min_width = 200
c.tabs.padding = {"top": 5, "bottom": 5, "left": 5, "right": 5}
c.fonts.default_family = "DinaRemasterII Nerd Font"
c.fonts.default_size = "@font_size@pt"

# colors
c.colors.tabs.bar.bg = bg
c.colors.tabs.even.bg = bg
c.colors.tabs.even.fg = fg
c.colors.tabs.odd.bg = bg
c.colors.tabs.odd.fg = fg
c.colors.tabs.selected.even.bg = contrast_high
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.selected.odd.bg = contrast_high
c.colors.tabs.selected.odd.fg = fg

