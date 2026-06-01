{ 
  pkgs,
  spicetify-nix,
  ...
}:
let
  spicetify = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicetify.extensions; [
      betterGenres
      adblock
      aiBandBlocker
    ];

    theme = spicetify.themes.text;
  };
}
