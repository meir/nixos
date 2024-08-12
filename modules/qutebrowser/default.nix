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

  configFile = pkgs.writeScript "qutebrowser-config" ''
    ${readFile ./config.py}

    ${readFile config.modules."${name}".config}
  '';

  xorg = config.protocol.xorg.enable;
in
mkModule config name {
  options.modules."${name}" = {
    config = mkOption {
      type = types.path;
      default = ./config.py;
    };

    homepage = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
    #
    # greaseMonkey = mkOption {
    #   type = types.path;
    #   default = null;
    # };
    #
    # userScripts = mkOption {
    #   type = types.path;
    #   default = null;
    # };
  };

  config = {
    environment.packages = with pkgs; [
      qutebrowser
      jq
    ];

    xdg.mime.defaultApplications = mkIf xorg {
      "text/html" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" = "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" = "org.qutebrowser.qutebrowser.desktop";
    };

    environment.file = {
      qutebrowser_config = {
        source = pkgs.substituteAll {
          src = configFile;
          homepage = config.modules."${name}".homepage or "";
        };
        target = ".config/qutebrowser/config.py";
      };

      qutebrowser_greaseMonkey = {
        # source = config.modules."${name}".greaseMonkey;
        source = ./greasemonkey;
        target = ".config/qutebrowser/greasemonkey";
      };

      quetebrowser_userScripts = {
        # source = config.modules."${name}".userScripts;
        source = ./userscripts;
        target = ".config/qutebrowser/userscripts";
      };
    };
  };
}
