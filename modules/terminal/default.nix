{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "kitty" {
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
    source = ./kitty.conf;
    target = ".config/kitty/kitty.conf";
  };

  sxhkd.keybind."super + Return" = "kitty";
}
