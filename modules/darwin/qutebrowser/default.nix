{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  configFile = pkgs.writeScript "qutebrowser-config" ''
    ${readFile ../../../config/qutebrowser/config.py}

    ${readFile config.modules.qutebrowser.config}
  '';
in
{
  options.modules.qutebrowser = {
    enable = mkEnableOption "qutebrowser";

    config = mkOption {
      type = types.path;
      default = ../../../config/qutebrowser/config.py;
    };

    homepage = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };

  config = mkIf config.modules.qutebrowser.enable {
    homebrew = {
      enable = true;
      casks = [ "qutebrowser" ];
    };

    home-manager.users."${config.user}".home.file = {
      ".qutebrowser/config.py" = {
        source = pkgs.substituteAll {
          src = configFile;
          homepage = config.modules.qutebrowser.homepage or "";
        };
      };

      ".qutebrowser/greasemonkey" = {
        source = ../../../config/qutebrowser/greasemonkey;
      };

      ".qutebrowser/userscripts" = {
        source = ../../../config/qutebrowser/userscripts;
      };
    };
  };
}
