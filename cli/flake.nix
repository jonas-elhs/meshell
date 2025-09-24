{
  description = "CLI for meshell shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux = rec {
      meshell = pkgs.callPackage ./default.nix {};
      default = meshell;
    };

    devShells.x86_64-linux = {
      default = pkgs.mkShellNoCC {
        packages = [ self.packages.x86_64-linux.meshell ];
      };
    };
  };
}
