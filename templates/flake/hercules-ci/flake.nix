{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem =
        { self', pkgs, ... }:
        {
          packages.default = pkgs.callPackage ./default.nix {};

          devShells.default = pkgs.mkShell {
            packages = [  ];
          };

          apps.default = {
            type = "app";
            program = self'.packages.default;
          };
        };
    };
}

