{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crane.url = "github:ipetkov/crane";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      crane,
      flake-utils,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import rust-overlay) ];
        };

        craneLib = (crane.mkLib pkgs).overrideToolchain (p: p.rust-bin.nightly.latest.default);
        craneArgs = {
          src = craneLib.cleanCargoSource ./.;
          strictDeps = true;
        };
      in
      {
        checks = {
          inherit (self.packages.${system}) default;
        };

        packages = {
          default = craneLib.buildPackage (
            craneArgs
            // {
              cargoArtifacts = craneLib.buildDepsOnly craneArgs;
              meta.mainProgram = "wvm-backend";
            }
          );
        };

        devShells.default = craneLib.devShell {
          checks = self.checks.${system};
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
      }
    );
}
