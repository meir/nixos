{ pkgs, ... }@inputs:
{
  imports = [
    ./nix.nix
    ./user.nix
    ./settings.nix
    ./fonts.nix

    # themes
    ../../themes/evergreen

    ../modules
  ];

  nixpkgs.overlays = [
    (import ../../overlays/nixpkgs-unstable.nix inputs)
    (import ../../overlays/packages.nix inputs)
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  services.nix-daemon.enable = true;
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = 4;
}
