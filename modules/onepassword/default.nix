{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules._1password.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules._1password.enable {
    environment.packages = with pkgs; [ _1password ];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "1password-gui" "1password" ];

    programs._1password.enable = true;
    programs._1password-gui.enable = true;
  };
}
