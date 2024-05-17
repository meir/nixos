{ lib, pkgs, options, config, ... }@inputs:
with lib;
with builtins;
let
  getModule = (dir: (name: type:
    let
      path = "${dir}/${name}";
      value = nameValuePair name (import path);
      default = nameValuePair "" null;
    in ({
      "directory" = if pathExists "${path}/default.nix" then
        value
      else default;
      "regular" = if name != "default.nix" && hasSuffix ".nix" name then
        value
      else default;
    })."${type}" or default));
  
  mapModules = dir:
    filterAttrs (n: v: v != null) (
      mapAttrs'
        (getModule dir)
        (readDir dir)
    );

in {
  imports = attrValues (mapModules ./.);
}
