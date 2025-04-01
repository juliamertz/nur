{
  pins,
  rustPlatform,
  lib,
  makeWrapper,
  nix,
  nixfmt-rfc-style,
  ...
}:
let
  src = pins.sources.nixpins;
  manifest = lib.importTOML "${src}/Cargo.toml";
in
rustPlatform.buildRustPackage {
  inherit (manifest.package) name version;
  inherit src;

  nativeBuildInputs = [ makeWrapper ];
  postInstall = ''
    wrapProgram "$out/bin/nixpins" --set PATH "${
      lib.makeBinPath [
        nix
        nixfmt-rfc-style
      ]
    }"
  '';

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  meta = {
    homepage = "https://github.com/juliamertz/nixpins";
    mainProgram = "nixpins";
  };
}
