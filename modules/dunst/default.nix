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
with lib;
{
  options.modules."${name}" = {
    enable = mkEnableOption "${name}";

    source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  };

  config = mkIf (xorg && config.modules."${name}".enable) {
    environment.systemPackages = with pkgs; [ dunst ];

    hm.home.file.".config/dunst" = mkIf (config.modules."${name}".source != null) {
      source = config.modules."${name}".source;
    };
  };
}
