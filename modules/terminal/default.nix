{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
let
  name = "kitty";
in
recursiveUpdate
  {
    options.modules."${name}".config = mkOption {
      type = types.path;
      default = ./kitty.conf;
    };
  }
  (
    mkModule config "${name}" {
      environment.packages = with pkgs; [
        kitty

        # terminal tools
        btop
        nvtopPackages.full
        fastfetch
        xdotool
        cargo
        rustc
      ];

      environment.file.kitty = {
        source = config.modules."${name}".config;
        target = ".config/kitty/kitty.conf";
      };

      sxhkd.keybind."super + Return" = "kitty";
    }
  )
