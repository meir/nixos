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
      nerd-fonts.mononoki
      nerd-fonts.roboto-mono
    ];
  };
}
