{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.aerospace.enable = mkEnableOption "aerospace";

  config = mkIf config.modules.aerospace.enable {
    environment.systemPackages = with pkgs; [
      jq
      unstable.aerospace
    ];

    home-manager.users."${config.user}".home.file = {
      ".config/aerospace/aerospace.toml" = {
        source = ../../../config/aerospace/aerospace.toml;
      };
    };

    services = {
      jankyborders = {
        enable = true;
        width = 8.0;
        style = "round";
        active_color = "0xFFD1496B";
        inactive_color = "0xFF10A070";
        hidpi = true;
      };
    };
  };
}
