{
  nixpkgs,
  ...
}:
let
  inherit (nixpkgs) lib;
in
nixpkgs.lib
// rec {
  # mkFlake =
  #   attrs:
  #   inputs.flake-parts.lib.mkFlake { inputs = { }; } {
  #     systems = attrs.systems or nixpkgs.lib.systems.flakeExposed;
  #     perSystem = attrs.perSystem;
  #   };

  systems = import ../lib/systems.nix;

  eachSystem = systems: func: lib.genAttrs systems (system: func system);
  allSystems = eachSystem systems.default;
  allSystemsPkgs = func: lib.genAttrs systems.default (system: func nixpkgs.legacyPackages.${system});

  # merge list of overlays into single overlay
  mergeOverlays =
    overlays: final: prev:
    map (overlay: overlay final prev) overlays |> lib.mergeAttrsList;

  # Read entries in directory as list of paths
  readDirPaths = dir: builtins.readDir dir |> lib.mapAttrsToList (name: _: dir + "/${name}");

  packagesFromLegacy =
    system: legacyPackages:
    nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) legacyPackages.${system};

  importUnfree =
    system: input:
    import input {
      inherit system;
      config.allowUnfree = true;
    };
}
