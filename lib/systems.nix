rec {
  default = linux ++ darwin;
  linux = [ "x86_64-linux" "aarch64-linux" ];
  darwin = [ "x86_64-darwin" "aarch64-darwin" ];
}
