{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "qutebrowser" {
  environment.packages = with pkgs; [ qutebrowser ];

  environment.file.qutebrowser = {
    source = ./config.py;
    target = ".config/qutebrowser/config.py";
  };

  environment.file.qutebrowser_homepage = {
    source = ./homepage;
    target = ".config/qutebrowser/homepage";
  };

  environment.file.qutebrowser_greasemonkey = {
    source = ./greasemonkey;
    target = ".config/qutebrowser/greasemonkey";
  };
}
