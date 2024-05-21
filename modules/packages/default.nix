{ unstable, config, options, pkgs, lib, ... }:
with lib;
{
  options.modules.packages = mkOption {
    type = types.listOf types.package;
  };

  config = {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = config.modules.packages;
  };
}
