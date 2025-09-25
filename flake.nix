{
  description = "CLI for meshell shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux = rec {
      cli = pkgs.callPackage ./cli/package.nix {};
      default = cli;
    };

    devShells.x86_64-linux = {
      default = pkgs.mkShellNoCC {
        packages = [ self.packages.x86_64-linux.cli ];
      };
    };
  };
}
