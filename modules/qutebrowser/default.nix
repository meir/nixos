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
    options.modules."${name}" = {
      config = mkOption {
        type = types.path;
        default = ./config.py;
      };

      homepage = mkOption {
        type = types.nullOr types.path;
        default = null;
      };

      greaseMonkey = mkOption {
        type = types.nullOr types.path;
        default = null;
      };

      userScripts = mkOption {
        type = types.nullOr types.path;
        default = null;
      };
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
          text = pkgs.substituteAll {
            src = (readFile ./config.py) ++ (readFile config.modules."${name}".config);
            homepage = config.modules."${name}".homepage;
          };
          target = ".config/qutebrowser/config.py";
        };

        qutebrowser_homepage = mkIf config.modules."${name}".homepage {
          source = config.modules."${name}".homepage;
          target = ".config/qutebrowser/homepage";
        };

        qutebrowser_greaseMonkey = {
          source = config.modules."${name}".greaseMonkey;
          target = ".config/qutebrowser/greasemonkey";
        };

        quetebrowser_userScripts = {
          source = config.modules."${name}".userScripts;
          target = ".config/qutebrowser/userscripts";
        };
      };
    }
  )
