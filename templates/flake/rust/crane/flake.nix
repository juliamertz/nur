{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crane.url = "github:ipetkov/crane";
  };

  outputs =
    {
      self,
      nixpkgs,
      crane,
    }:
    let
      forEachSystem =
        f:
        nixpkgs.lib.genAttrs (nixpkgs.lib.systems.flakeExposed) (
          system: f nixpkgs.legacyPackages.${system}
        );
    in
    {
      packages = forEachSystem (
        pkgs:
        let
          craneLib = crane.mkLib pkgs;
          commonArgs = {
            src = craneLib.cleanCargoSource ./.;
            strictDeps = true;
            buildInputs = [ ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [ pkgs.libiconv ];
          };
        in
        {
          default = craneLib.buildPackage (
            commonArgs
            // {
              cargoArtifacts = craneLib.buildDepsOnly commonArgs;
              meta.mainProgram = "noogle";
            }
          );
        }
      );

      checks = forEachSystem (pkgs: {
        inherit (self.packages.${pkgs.system}) default;
      });

      devShells = forEachSystem (pkgs:
        let craneLib = crane.mkLib pkgs; in
        {
          default = craneLib.devShell {
            checks = self.checks.${pkgs.system};
            packages = with pkgs; [ ];
          };
        }
      );
    };
}
