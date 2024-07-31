{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "qutebrowser" {
  environment.packages = with pkgs; [ qutebrowser ];

  environment.file = {
    qutebrowser = {
      source = ./config.py;
      target = ".config/qutebrowser/config.py";
    };

    qutebrowser_homepage = {
      source = ./homepage;
      target = ".config/qutebrowser/homepage";
    };

    qutebrowser_greasemonkey = {
      source = ./greasemonkey;
      target = ".config/qutebrowser/greasemonkey";
    };

    qutebrowser_userscripts = {
      source = ./userscripts;
      target = ".local/share/qutebrowser/userscripts";
    };
  };
}
