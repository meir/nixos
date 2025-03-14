{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  name = "qutebrowser";

  configFile = pkgs.writeScript "qutebrowser-config" ''
    ${readFile ../../config/qutebrowser/config.py}

    ${readFile config.modules."${name}".config}
  '';

  xorg = config.protocol.xorg.enable;
in
{
  options.modules."${name}" = {
    enable = mkEnableOption "qutebrowser";

    config = mkOption {
      type = types.path;
      default = ../../config/qutebrowser/config.py;
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

  config = mkIf config.modules."${name}".enable {
    environment.systemPackages = with pkgs; [
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
  };
}
