{
  config,
  pkgs,
  lib,
  ...
}:
let
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
in
{
  imports = [
    ./bootloader.nix
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./nixos.nix
    ./security.nix
    ./user.nix
    ./fonts.nix
    ./packages.nix
    ./protocol.nix
    ./hotkeys.nix
  ];

  environment.defaultPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "24.05";
}
