{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  services.greetd = mkIf config.protocol.wayland.enable {
    package = pkgs.unstable.greetd;
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --time --asterisks --user-menu --cmd 'dbus-run-session Hyprland'";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    hyprland
    bash
  '';
}
