let
  mkModule = path: {
    source = path;
    overrides = {};

    override = o: {
      source = path;
      overrides = o;
    };
  };

  safeImport = inputs: module: import module.source (inputs // (module.overrides or {}));
  useMods = inputs: mods: builtins.map (m: safeImport inputs m) mods;
in {
  inherit useMods;
} // builtins.mapAttrs (name: value: mkModule value) (import ../modules.nix)
