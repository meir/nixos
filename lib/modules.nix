let
  mkModule = path: {
    source = path;
    overrides = {};

    override = o: {
      source = path;
      overrides = o;
    };
  };

  safeImport = assets: inputs: module: import module.source (inputs // (module.overrides or {}) // {
    inherit assets;
  });
  useMods = assets: inputs: mods: builtins.map (m: safeImport assets inputs m) mods;
in {
  inherit useMods;
} // builtins.mapAttrs (name: value: mkModule value) (import ../modules.nix)
