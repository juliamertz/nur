{
  description = "Personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    rec {
      lib = import ./lib { inherit nixpkgs; };
      overlays = import ./overlays;
      templates = import ./templates/flake;

      packages = lib.allSystems (system: lib.packagesFromLegacy system self.legacyPackages);
      legacyPackages = lib.allSystems (system: import ./default.nix { inherit system nixpkgs; });
    };
}
