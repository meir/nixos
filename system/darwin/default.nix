{ pkgs, ... }:
{
  imports = [
    ./nix.nix

    ../../modules/common
    ../../modules/darwin
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "4";
}
