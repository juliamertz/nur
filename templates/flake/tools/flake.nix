{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

    tools = {
      # url = "github:juliamertz/nix-toolbox";
      url = "path:../../../";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    { tools, systems, ... }:
    tools.lib.mkFlake {
      systems = import systems;

      eachSystem =
        { self', pkgs, ... }:
        {
          packages.default = pkgs.stdenv.mkDerivation {
            name = "pkg";
            version = "0.0.0";
            src = ./.;
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [ ];
          };

          templates = {
            tools = {
              path = ./.;
            };
          };
        };
    };
}
