config.load_autoconfig()

c.auto_save.session = True

c.tabs.background = True
c.tabs.select_on_remove = "prev"
c.tabs.new_position.unrelated = "next"
c.tabs.min_width = 200
c.tabs.position = "left"

c.url.default_page = "~/.config/qutebrowser/homepage/index.html"
c.url.start_pages = [c.url.default_page]

c.content.autoplay = False
