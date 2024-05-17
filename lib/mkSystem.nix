{ ... }@inputs: system: name: inputs.nixpkgs.lib.nixosSystem (
  {
    inherit system;
    modules = [
      # ./file.nix TODO: add file.nix once code is complete in there.
       ./user.nix

      ../hosts/${name}/hardware-configuration.nix
      ../hosts/${name}/configuration.nix
    ];
  }
)
