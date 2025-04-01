{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zon2nix = {
      url = "github:nix-community/zon2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, zon2nix, ... }:
    let
      forAllSystems =
        function:
        nixpkgs.lib.genAttrs (nixpkgs.lib.systems.flakeExposed) (
          system: function nixpkgs.legacyPackages.${system}
        );
    in
    {
      packages = forAllSystems (
        pkgs: with pkgs; {
          default = stdenv.mkDerivation (finalAttrs: {
            pname = "my-zig-project";
            version = "0.0.1";
            src = ./.;

            nativeBuildInputs = [ zig_0_14.hook ];
            zigBuildFlags = [ "-Doptimize=ReleaseFast" ];

            # postPatch = ''
            #   ln -s ${callPackage ./deps.nix { }} $ZIG_GLOBAL_CACHE_DIR/p
            # '';

            meta.mainProgram = finalAttrs.pname;
          });
        }
      );

      devShells = forAllSystems (
        pkgs: with pkgs; {
          default = mkShell {
            packages = [
              zon2nix.packages.${system}.default
              zig
              zls
            ];
          };
        }
      );
    };
}
