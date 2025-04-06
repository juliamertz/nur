rec {
  default = tools-flake;

  tools-flake = {
    path = ./flake/tools;
    description = "Minimal using this repo's mkFlake";
  };

  minimal-flake = {
    path = ./flake/minimal;
    description = "A very simple flake";
  };

  systems-flake = {
    path = ./flake/systems;
    description = "Minimal flake using nix-systems";
  };

  hercules-ci-flake = {
    path = ./flake/hercules-ci;
    description = "Basic flake using Hercules CI flake-parts";
  };

  rust-flake = {
    path = ./flake/rust/default;
    description = "Rust development flake";
  };

  rust-crane-flake = {
    path = ./flake/rust/crane;
    description = "Rust development flake with cranelib";
  };

  zig-flake = {
    path = ./flake/zig;
    description = "Zig development flake";
  };
}
