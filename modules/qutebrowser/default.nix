{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.qutebrowser.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.qutebrowser.enable {
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
  };
}
