{
  description = "identityapproved's nixos homelab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nvf.url = "github:NotAShelf/nvf";
  };

  outputs = { self, nixpkgs, nvf, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          nvf.nixosModules.default
        ];
      };
    };
}
