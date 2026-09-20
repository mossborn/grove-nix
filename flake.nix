# ~/nixos/flake.nix
{
  description = "nixbox: Hyprland (Lua) + Noctalia v5 desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # The cachix branch always points at a commit Noctalia's CI already built.
    # No `follows` here on purpose: overriding nixpkgs causes cache misses.
    noctalia.url = "github:noctalia-dev/noctalia/cachix";

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium-flake = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      username = "moss";
      hostname = "grove";
      dotfiles = "/home/${username}/nixos/dotfiles";
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs username hostname dotfiles; };
        modules = [
          ./hosts/nixbox/configuration.nix
          ./modules/desktop.nix
          ./modules/gaming.nix
          ./modules/dev.nix
        ];
      };
    };
}
