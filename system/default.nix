{
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./nixos.nix
    ./security.nix
    ./user.nix
    ./fonts.nix
    ./applications.nix
    ./terminal.nix
    ./storage.nix
    ./style.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../overlays/packages.nix inputs)
  ];

  nix-fs.files.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

  environment.systemPackages = with pkgs; [
    curl
    git-credential-manager
    pass
    gcc
    libgcc
    opencl-headers
    ocl-icd
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  system.stateVersion = "25.11";
}
