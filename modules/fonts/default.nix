{ config, options, pkgs, lib, ... }:
with lib; {
  config = {
    modules.packages = with pkgs; [
      mononoki
      (nerdfonts.override { fonts = [ "Mononoki" ]; })
    ];
  };
}
