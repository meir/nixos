{ nixpkgs-unstable, ... }:
final: prev: { unstable = import nixpkgs-unstable (final // { config.allowUnfree = true; }); }
