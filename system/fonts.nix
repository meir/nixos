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
      cozette-nerdfont
      dina-remastered
      # (nerdfonts.override {
      #   fonts = [
      #     "Mononoki"
      #     "RobotoMono"
      #   ];
      # })
    ];
  };
}
