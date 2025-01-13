{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
{
  options.modules.qutebrowser = {
    enable = mkEnableOption "qutebrowser";

    homepage = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };

  config = mkIf config.modules.qutebrowser.enable {
    homebrew = {
      enable = true;
      casks = [
        "qutebrowser"
        "firefox"
      ];
    };

    home-manager.users."${config.user}".home.file = {
      ".qutebrowser/config.py".source = ./config.py;
      ".qutebrowser/userscripts".source = ./userscripts;
    };
  };
}
