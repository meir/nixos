{ pkgs, ... }@inputs:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./nixos.nix
    ./security.nix
    ./user.nix
    ./fonts.nix
    ./protocol.nix
    ./izu.nix
    ./applications.nix

    # themes
    ../themes/evergreen/linux.nix

    ../modules
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../overlays/nixpkgs-unstable.nix inputs)
    (import ../overlays/nixpkgs-xr.nix inputs)
    (import ../overlays/packages.nix inputs)
  ];

  environment.systemPackages = with pkgs; [ curl ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  system.stateVersion = "24.05";
}
