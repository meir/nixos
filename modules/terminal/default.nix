{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.kitty.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.kitty.enable {
    environment.packages = with pkgs; [
      kitty

      # terminal tools
      btop
      nvtopPackages.full
      fastfetch
      onefetch
      wallust
      xdotool
    ];

    environment.file.kitty = {
      source = ./kitty.conf;
      target = ".config/kitty/kitty.conf";
    };

    sxhkd.keybind."super + Return" = "kitty";
  };
}
