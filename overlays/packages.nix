{ pkgs, izu, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  walld = callPackage ../pkgs/walld { };
  replace = callPackage ../pkgs/replace { };
  discord_wayland = pkgs.symlinkJoin {
    name = "discord-wrapped";
    paths = [
      (discord.override { withOpenASAR = true; })
    ];
    buildInputs = [ makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/Discord --set XDG_SESSION_TYPE x11
      wrapProgram $out/bin/discord --set XDG_SESSION_TYPE x11
    '';
  };
}
