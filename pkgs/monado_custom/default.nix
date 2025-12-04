{ monado, fetchgit, ...}:
monado.overrideAttrs (old: {
  src = fetchgit {
    url = "https://tangled.org/@matrixfurry.com/monado";
    rev = "ecf484dd36c2bb475616189dbc222f5dc9c1c396";
    hash = "sha256-+Y6Y3J+UDa7UuYAlEMPwlhl2+FRxu7diXdBr5m8TIYs=";
  };
})
