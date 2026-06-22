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
    rev = "44a12f383690a1221b6023ed8671adc91f71f6a9";
    hash = "sha256-r6/hiGqq2rr/IWXkPi5oIBwsuD3RTzFTeovrK5n+/pY=";
  };

  cargoHash = "sha256-pg0bMk+SjFCE9t4YMrLjNX3JzLEIMi2GNEQdv8lzDwk=";
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
