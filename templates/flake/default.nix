{
  tools = {
    path = ./tools;
    description = "Minimal using this repo's mkFlake";
  };

  minimal = {
    path = ./minimal;
    description = "A very simple flake";
  };

  systems = {
    path = ./systems;
    description = "Minimal flake using nix-systems";
  };

  hercules-ci = {
    path = ./hercules-ci;
    description = "Basic flake using Hercules CI flake-parts";
  };

  rust = {
    path = ./rust/default;
    description = "Rust development flake";
  };

  rust-crane = {
    path = ./rust/crane;
    description = "Rust development flake with cranelib";
  };

  zig = {
    path = ./zig;
    description = "Zig development flake";
  };

  astro-site = {
    path = ./astro-site;
    description = "Static astro website flake";
  };
}
