{
  lib,
  fetchFromGitHub,
  ...
}:
picom.overrideAttrs (previousAttrs: {
  pname = "walld";
  version = "02db1883195dbd27509b9a87e20e898201ba0140";

  src = fetchFromGitHub {
    owner = "ronniedroid";
    repo = "Wall-d";
    rev = "02db1883195dbd27509b9a87e20e898201ba0140";
    hash = "sha256-bXeoWg1ZukXv+6ZNeRc8gGNsbtBztyW5lpfK0lQK+DE=";
  };

  meta = {
    mainProgram = "wall-d"
    description = "A simple and fast wallpaper manager";
    homepage = "https://github.com/ronniedroid/Wall-d";
  };
}
