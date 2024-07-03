{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
mkModule "kitty" {
  environment.packages = with pkgs; [
    kitty

    # terminal tools
    btop
    nvtopPackages.full
    fastfetch
    onefetch
    wallust
    xdotool
    cdl
    cargo
    rustc
  ];

  environment.file.kitty = {
    source = ./kitty.conf;
    target = ".config/kitty/kitty.conf";
  };

  sxhkd.keybind."super + Return" = "kitty";
}
