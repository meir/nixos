{ monado, fetchgit, ...}:
monado.overrideAttrs (old: {
  src = fetchgit {
    url = "https://tangled.org/@matrixfurry.com/monado";
    rev = "c597b209f920cf2248d1eaa9bad738d4ac3134aa";
    hash = "";
  };
})
