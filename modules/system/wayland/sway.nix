{ pkgs, config, ... }:
let
  buildSway = pkgs.writeScript "init" (''
    ${concatStringsSep "\n" config.protocol.rules}
  '');
in
{
  environment.defaultPackages = with pkgs; [ xorg.xf86videonouveau ];

  programs.sway = {
    enable = true;

    xwayland.enable = true;
  };

  environment.file.sway = {
    source = buildSway;
    target = ".config/sway/config";
  };
}
