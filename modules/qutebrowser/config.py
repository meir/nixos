config.load_autoconfig()

c.auto_save.session = True
c.url.searchengines = {
  "DEFAULT": "https://www.google.com/search?q={}",
}

c.tabs.background = True
c.tabs.select_on_remove = "prev"
c.tabs.new_position.unrelated = "next"
c.tabs.min_width = 200
c.tabs.position = "left"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 5, "right": 5}
c.tabs.mousewheel_switching = False
c.fonts.default_family = "DinaRemasterII Nerd Font"
c.fonts.default_size = "12pt"
# colors
c.colors.tabs.bar.bg = "#000"
c.colors.tabs.even.bg = "#000"
c.colors.tabs.even.fg = "#fff"
c.colors.tabs.odd.bg = "#000"
c.colors.tabs.odd.fg = "#fff"
c.colors.tabs.selected.even.bg = "#2FA"
c.colors.tabs.selected.even.fg = "#fff"
c.colors.tabs.selected.odd.bg = "#2FA"
c.colors.tabs.selected.odd.fg = "#fff"

c.url.default_page = "~/.config/qutebrowser/homepage/index.html"
c.url.start_pages = [c.url.default_page]

c.content.autoplay = False
