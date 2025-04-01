{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    tools.url = "path:../../../../";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, tools, ... }@inputs:
    tools.lib.mkFlake {
      perSystem =
        { lib, system, ... }:
        let
          overlays = [ (import inputs.rust-overlay) ];
          pkgs = import (inputs.nixpkgs) { inherit system overlays; };

          manifest = (lib.importTOML ./Cargo.toml);
          rustPlatform = pkgs.makeRustPlatform {
            cargo = pkgs.rust-bin.stable.latest.minimal;
            rustc = pkgs.rust-bin.stable.latest.minimal;
          };
        in
        {

          packages.default = rustPlatform.buildRustPackage {
            inherit (manifest.package) name version;
            src = ./.;

            cargoLock = {
              lockFile = ./Cargo.lock;
              allowBuiltinFetchGit = true;
            };
          };

          devShells.default = pkgs.mkShell {
            checks = self.checks.${pkgs.system};

            packages = with pkgs.rust-bin; [
              nightly.latest.rustfmt
              nightly.latest.rust-analyzer
              (nightly.latest.minimal.override {
                extensions = [
                  "clippy"
                  "rust-src"
                ];
              })
            ];
          };
        };
    };
}
