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
    homebrew = {
      enable = true;
      casks = [ "1password" ];
    };
  };
}
