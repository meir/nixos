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

c.url.default_page = "@homepage@"
if c.url.default_page == "":
    c.url.default_page = c.url.searchengines['DEFAULT']
c.url.start_pages = [c.url.default_page]

c.content.autoplay = False
c.content.javascript.clipboard = "access"
