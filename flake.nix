{
  description = "Personal NUR repository";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-fast-build.url = "github:Mic92/nix-fast-build";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = import ./lib { inherit nixpkgs; };
      overlays = import ./overlays { inherit self lib; };
      templates = import ./templates;
    in
    rec {
      inherit lib overlays templates;

      packages = lib.allSystemsPkgs (
        pkgs: import ./pkgs (pkgs.appendOverlays [ overlays.default ] // { inherit inputs; })
      );

      checks = lib.allSystemsPkgs (
        pkgs:
        self.packages.${pkgs.system}
        |> lib.filterAttrs (_: p: lib.elem pkgs.system (p.meta.platforms or lib.systems.default))
      );

      devShells = lib.allSystemsPkgs(pkgs: {
        default = pkgs.mkShell {
          packages = [
            inputs.nix-fast-build.packages.${pkgs.system}.default
          ];
        };
      });
    };
}
