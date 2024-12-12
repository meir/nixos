{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with builtins;
let
  name = "evergreen";
  cfg = config.theme."${name}";
  values = {
    inherit (cfg) font_size dpi;
  };
in
{
  options.theme."${name}" = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    font_size = mkOption {
      type = types.int;
      default = 16;
    };

    dpi = mkOption {
      type = types.int;
      default = 1;
    };
  };

  config = {
    modules = with pkgs; {
      qutebrowser = {
        homepage = replace.override {
          src = ./qutebrowser/homepage;
          args = values;
        };
        config = replace.override {
          src = ./qutebrowser/config.py;
          args = values;
        };
      };
    };
  };
}
