{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  llvm,
  onnxruntime,
  makeWrapper,
  lib,
  ...
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "snout-cli";
  version = "main";

  src = fetchFromGitHub {
    owner = "Darksecond";
    repo = "libsnout";
    rev = "8cea03e97030d8239fe953e6e1a769cce19b2e4a";
    hash = "sha256-bsw+lOdodp2RiJ/QeS9VUhXI9vm19hhQnHZrVJjCbYw=";
  };

  cargoHash = "sha256-Q2tUb3ozmNBQbMkRQiV6n9UJbEE0QfSCi++0u0W/oEI=";
  cargoBuildFlags = [ "--package" "snout-cli" ];

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    makeWrapper
  ];

  buildInputs = [
    llvm
    onnxruntime
  ];

  postFixup = ''
    wrapProgram "$out/bin/snout-cli" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ onnxruntime llvm ]}"
  '';

  meta = {
    description = "A library for snout detection and tracking";
    homepage = "https://github.com/Darksecond/libsnout";
    platforms = lib.platforms.linux;
    mainProgram = "snout-cli";
  };
})
