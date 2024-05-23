{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.mako.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.mako.enable {
    modules.packages = with pkgs; [ mako ];
  };
}
