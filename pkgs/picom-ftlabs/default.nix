{
  picom,
  lib,
  writeShellScript,
  fetchFromGitHub,
  pcre,
  unstableGitUpdater,
  ...
}:
picom.overrideAttrs (previousAttrs: {
  pname = "picom-ftlabs";
  version = "b99c7db73eb62204568c21d9542dce5388d4d356";

  src = fetchFromGitHub {
    owner = "pijulius";
    repo = "picom";
    rev = "b99c7db73eb62204568c21d9542dce5388d4d356";
    hash = "sha256-bXeoWg1ZukXv+6ZNeRc8gGNsbtBztyW5lpfK0lQK+DE=";
  };

  buildInputs = (previousAttrs.buildInputs or [ ]) ++ [ pcre ];

  meta = {
    inherit (previousAttrs.meta)
      license
      platforms
      mainProgram
      longDescription
      ;

    description = "FT-Labs picom fork with extensive animation support";
    homepage = "https://github.com/FT-Labs/picom";
  };
})
