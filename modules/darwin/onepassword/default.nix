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
      _1password
    ];
  };
}
