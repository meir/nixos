{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = {
    fonts.packages = with pkgs; [
      ../../pkgs/cozette-nerdfont/default.nix
      (nerdfonts.override {
        fonts = [
          "Mononoki"
          "RobotoMono"
        ];
      })
    ];
  };
}
