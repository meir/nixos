{
  options,
  config,
  lib,
  ...
}@inputs:
name: cfg: with lib; {
  options.modules.${name}.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = (mkIf options.modules.${name}.enable cfg);
}
