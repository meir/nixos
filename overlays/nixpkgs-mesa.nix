{ nixpkgs-mesa, ... }:
final: prev: { nixpkgs-mesa = import nixpkgs-mesa (final // { config.allowUnfree = true; }); }
