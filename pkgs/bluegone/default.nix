{
  inputs,
  lib,
  rustPlatform,
  pkg-config,
  openssl,
  cmake,
}:

rustPlatform.buildRustPackage {
  pname = "bluegone";
  version = "0.2.0";
  src = inputs.bluegone;

  cargoHash = "sha256-s5u0y0o1k/d0Uj6QcXR12HhT4Iwi3RmIxRpxV7adXPs=";

  buildInputs = [ openssl ];
  nativeBuildInputs = [
    pkg-config
    cmake
    rustPlatform.bindgenHook
  ];

  buildNoDefaultFeatures = true;

  meta = {
    description = "A blue light filter for x11 desktops";
    homepage = "https://github.com/juliamertz/bluegone";
    mainProgram = "bluegone";
    platforms = lib.platforms.linux;
  };
}
