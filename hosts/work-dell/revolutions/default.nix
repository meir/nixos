{ ... }:
let
  replace = src: builtin.substituteAll { inherit src; };
in
{
  config = {
    bspwm.rules = [
      "bspc config normal_border_color '#131711'"
      "bspc config active_border_color '#10A070'"
      "bspc config focused_border_color '#D1496B'"
      "bspc config border_width 2"
    ];

    modules = {
      dunst.source = ./dunst;
      eww.source = ./eww;
      rofi.source = ./rofi;
      qutebrowser.config = ./qutebrowser/config.py;
      kitty.config = ./kitty/kitty.conf;
    };
  };
}
