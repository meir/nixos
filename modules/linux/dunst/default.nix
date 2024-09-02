{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  name = "dunst";
  xorg = config.protocol.xorg.enable;
in
pkgs.mkModule config "${name}" {
  only = xorg;

  options.modules."${name}".source = mkOption {
    type = types.nullOr types.path;
    default = null;
  };

  config = {
    environment.packages = with pkgs; [ dunst ];

    environment.file.dunst = mkIf (config.modules."${name}".source != null) {
      source = config.modules."${name}".source;
      target = ".config/dunst";
    };
  };
}
