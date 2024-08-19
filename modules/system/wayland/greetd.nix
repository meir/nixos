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
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --asterisks --cmd river";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    river
    bash
  '';
}
