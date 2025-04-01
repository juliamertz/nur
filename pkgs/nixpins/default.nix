{
  rustPlatform,
  lib,
  makeWrapper,
  nix,
  nixfmt-rfc-style,
  callPackage,
  ...
}:
let
  pins = callPackage ../../pins.nix { };
  src = pins.sources.nixpins;

  manifest = lib.importTOML "${src}/Cargo.toml";
  runtimeDeps = lib.makeBinPath [
    nix
    nixfmt-rfc-style
  ];
in
rustPlatform.buildRustPackage {
  inherit (manifest.package) name version;
  inherit src;

  nativeBuildInputs = [ makeWrapper ];
  postInstall = ''
    wrapProgram "$out/bin/nixpins" --set PATH "${runtimeDeps}"
  '';

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  meta.mainProgram = manifest.package.name;
}
