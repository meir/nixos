{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  services.picom = {
    enable = true;
    package = pkgs.picom-ftlabs;

    vSync = true;

    settings = {
      # Animations
      animations = true;
      animation-stiffness-in-tag = 125;
      animation-stiffness-tag-change = 90.0;

      animation-window-mass = 0.4;
      animation-dampening = 15;
      animation-clamping = true;

      animation-for-open-window = "zoom";
      animation-for-unmap-window = "squeeze";
      animation-for-transient-window = "slide-up";
      animation-for-prev-tag = "minimize";
      enable-fading-prev-tag = "true";
      animation-for-next-tag = "slide-in-center";
      enable-fading-next-tag = true;

      # Shadows
      shadow = false;
      shadow-radius = 5;
      shadow-opacity = 0.75;
      shadow-offset-x = -15;
      shadow-offset-y = -20;

      # Fading
      fading = true;
      fade-in-step = 0.2;
      fade-out-set = 0.2;
      fade-delta = 10;

      # Opacity
      active-opacity = 1.0;
      inactive-opacity = 0.9;
      frame-opacity = 1.0;

      # Corners
      corner-radius = 10;

      # Blurring
      backend = "glx";

      blur = {
        method = "dual_kawase";
        strength = 10;
        background = true;
        background-frame = false;
        background-fixed = false;
      };
    };
  };
}
