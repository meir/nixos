{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.qutebrowser.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.qutebrowser.enable {
    modules.packages = with pkgs; [ qutebrowser ];

    environment.file.qutebrowser = {
      source = ./config.py;
      target = ".config/qutebrowser/config.py";
    };
  };
}
