# this file was generated by nixpins (https://github.com/juliamertz/nixpins)
{ fetchFromGitHub, ... }:
{
  inputs = {
    nixpins = "github:juliamertz/nixpins";
  };
  sources = {
    nixpins = fetchFromGitHub {
      owner = "juliamertz";
      repo = "nixpins";
      rev = "e8410439655b74b97038352a8d3ec2d4c8a17fe3";
      hash = "sha256-JW8FbXWUKynzzilD7SvHVKqgr9+jlXMTpmOd2hdj9Z4=";
    };
  };
}
