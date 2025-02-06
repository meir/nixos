{ pkgs, nh, ... }:
{

  environment.systemPackages = with pkgs; [ nh.packages.${system}.nh ];

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
