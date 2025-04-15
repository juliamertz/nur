{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShell {
    packages = [
      cargo
      clippy
      rustfmt
      rust-analyzer
    ];

    RUST_SRC_PATH = "${rust.packages.stable.rustPlatform.rustLibSrc}";
  }
