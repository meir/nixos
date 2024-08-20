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
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd 'dbus-run-session sway'";
        };
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
      bash
    '';
  };
}
