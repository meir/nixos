{
  pkgs,
  lib,
  ...
}:
{
  config = {
    stylix = {
      enable = true;
      base16Scheme = {
        base00 = "#191c24"; # main background (void blue-black)
        base01 = "#23242d"; # sidebar background
        base02 = "#282b36"; # section/active background
        base03 = "#393c47"; # separators, muted
        base04 = "#7b7d86"; # muted text
        base05 = "#e5e6eb"; # main text
        base06 = "#f7f7fa"; # heading/bright text
        base07 = "#ffffff"; # highlight/white
        base08 = "#ff2d2d"; # red accent (error/hint)
        base09 = "#ffb347"; # orange accent (highlight)
        base0A = "#ffe066"; # yellow accent
        base0B = "#9effa1"; # green accent (success)
        base0C = "#7fdfff"; # cyan accent (links)
        base0D = "#8caaff"; # blue accent (selection)
        base0E = "#b5aaff"; # purple accent (subtle)
        base0F = "#7c6f57"; # brown (optional)
      };

      fonts = with pkgs; {
        serif = {
          package = dina-remastered;
          name = "Dina Remastered II";
        };
      };
    };
  };
}
