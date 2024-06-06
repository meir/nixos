{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.prismlauncher.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.prismlauncher.enable {
    environment.packages = with pkgs; [ prismlauncher ];
  };
}
