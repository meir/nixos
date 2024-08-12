{ lib, ... }:
config: name: cfg:
with lib;
let
  defaultOpt = {
    modules."${name}".enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  opts = cfg.options or { };
  imports = cfg.imports or [ ];
  only = cfg.only or true;
in
{
  inherit imports;
  options = recursiveUpdate defaultOpt opts;

  config = mkIf (only && config.modules."${name}".enable) (cfg.config or cfg);
}
