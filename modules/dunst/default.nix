{
  lib,
  options,
  config,
  pkgs,
  mkModule,
  ...
}:
with lib;
let
  name = "dunst";
  xorg = config.protocol.xorg.enable;
in
mkIf xorg (
  recursiveUpdate
    {
      options.modules."${name}".source = mkOption {
        type = types.nullOr types.path;
        default = null;
      };
    }
    (
      mkModule config "${name}" {
        environment.packages = with pkgs; [ dunst ];

        environment.file.dunst = mkIf (config.modules."${name}".source != null) {
          source = config.modules."${name}".source;
          target = ".config/dunst";
        };
      }
    )
)
