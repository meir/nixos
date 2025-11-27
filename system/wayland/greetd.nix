{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.protocol.wayland.enable {
    services.greetd = {
      enabled = true;
      package = pkgs.unstable.greetd;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd 'dbus-run-sesion Hyprland'";
        };
      };
    };
  };
}
