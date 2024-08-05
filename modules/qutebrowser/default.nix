{
  config,
  pkgs,
  lib,
  mkModule,
  ...
}:
with lib;
let
  name = "qutebrowser";
in
recursiveUpdate
  {
    options.modules."${name}".config = mkOption {
      type = types.path;
      default = ./config.py;
    };
  }
  (
    mkModule config name {
      environment.packages = with pkgs; [
        qutebrowser
        jq
      ];

      environment.file = {
        qutebrowser = {
          source = config.modules."${name}".config;
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
  )
