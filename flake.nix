{
  description = "CLI for meshell shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    wrappers,
  } @ inputs: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux = rec {
      quickshell = wrappers.wrappers.quickshell.wrap {
        inherit pkgs;

        configDir = ./.;
      };
      cli = pkgs.callPackage ./cli/package.nix {};
      default = cli;
    };
  };
}
