{
  description = "Haskell example flake for Zero to Nix";

  inputs = {
    # Latest stable Nixpkgs
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
  };

  outputs = { self, nixpkgs }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      packages = forAllSystems ({ pkgs }: {
        default = pkgs.haskellPackages.mkDerivation {
          pname = "zero-to-nix-haskell";
          version = "0.1.0";
          src = self;
          license = pkgs.lib.licenses.cc-by-sa-40;
          executableHaskellDepends = with pkgs.haskellPackages; [
            base
          ];
        };
      });
    };
}
