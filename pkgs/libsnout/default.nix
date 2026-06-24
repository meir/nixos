{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  llvm,
  onnxruntime,
  vulkan-loader,
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
    rev = "23c2cb2f840f379e302feea02a62458ca5222a4c";
    hash = "sha256-d9tWkYrJOqKLeJGM7JS5+TjVbbzCR/5pN1F5yRecrFI=";
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
    vulkan-loader
  ];

  postFixup = ''
    wrapProgram "$out/bin/snout-cli" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ onnxruntime llvm vulkan-loader ]}"
  '';

  meta = {
    description = "A library for snout detection and tracking";
    homepage = "https://github.com/Darksecond/libsnout";
    platforms = lib.platforms.linux;
    mainProgram = "snout-cli";
  };
})
