{
  symlinkJoin,
  discord,
  makeWrapper,
}:
symlinkJoin {
  name = "discord-wrapped";
  paths = [
    (discord.override { withOpenASAR = true; })
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/Discord --set XDG_SESSION_TYPE x11
    wrapProgram $out/bin/discord --set XDG_SESSION_TYPE x11
  '';
}
