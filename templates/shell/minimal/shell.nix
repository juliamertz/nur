{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    cowsay
    lolcat
  ];
}
