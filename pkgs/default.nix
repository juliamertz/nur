{
  pins,
  callPackage,
  libsForQt5,
  ...
}:
let
args = {inherit pins;};
in
{
  bluegone = callPackage ./bluegone args;
  nixpins = callPackage ./nixpins args;
  firefox-addons = callPackage ./firefox-addons args;
  sddm-rose-pine = libsForQt5.callPackage ./sddm-rose-pine args;
}
