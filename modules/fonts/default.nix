{ config, options, pkgs, lib, ... }:
with lib; {
  config = {
    fonts.packages = with pkgs; [
      mononoki
      (nerdfonts.override { fonts = [ "Mononoki" "RobotoMono" ]; })
    ];
  };
}
