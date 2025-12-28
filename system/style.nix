{
  pkgs,
  lib,
  ...
}:
{
  config = {
    # TODO: make themeing in nix somehow
    
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "adwaita-dark";
    };
  };
}
