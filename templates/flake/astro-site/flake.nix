{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    { nixpkgs, systems, ... }:
    let
      forAllSystems =
        function: nixpkgs.lib.genAttrs (import systems) (system: function nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.buildNpmPackage {
          name = "astro-site";
          src = ./.;

          buildInputs = with pkgs; [ nodejs_22 ];

          npmDepsHash = "sha256-24kP0LcGRuMB0nZxfFuIqAU5Ty2z8UQrMkvPSThJA64=";
          npmBuild = # sh
            ''
              npm run build
            '';

          installPhase = ''
            cp -r dist $out
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            deno # for running dev tasks
            nodejs # for installing dependencies
          ];
        };
      });
    };
}
