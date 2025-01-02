{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.onepassword.enable = mkEnableOption "onepassword";

  config = mkIf config.modules.onepassword.enable {
    environment.systemPackages = with pkgs; [
      _1password-gui
      _1password-cli
    ];

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "1password-gui"
        "1password-cli"
      ];

    programs._1password-gui.enable = true;
  };
}
