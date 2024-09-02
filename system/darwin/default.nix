{ pkgs, ... }:
{
  imports = [
    ./nix.nix
    ./file.nix

    ../../modules/common
    ../../modules/darwin
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "4";
}
