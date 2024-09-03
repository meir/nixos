{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options.modules.qutebrowser.enable = mkEnableOption "qutebrowser";

  config = mkIf config.modules.qutebrowser.enable {
    homebrew = {
      enable = true;
      casks = [ "qutebrowser" ];
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
        source = ../../../config/qutebrowser/greasemonkey;
        target = ".config/qutebrowser/greasemonkey";
      };

      quetebrowser_userScripts = {
        # source = config.modules."${name}".userScripts;
        source = ../../../config/qutebrowser/userscripts;
        target = ".config/qutebrowser/userscripts";
      };
    };
  };
}
