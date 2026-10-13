{
  description = "NixOS configuration with flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nix-index-database,
    nixvim,
    ...
  } @ inputs: {
    nixosConfigurations = {
      "framework" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs.flake-inputs = inputs; # make current inputs available as "flake-inputs" in configuration.nix
        modules = [
          # Load system configuration.
          ./hosts/framework/configuration.nix
          ./hosts/framework/hardware-configuration.nix

          # Apply hardware optimizations.
          nixos-hardware.nixosModules.framework-amd-ai-300-series

          # nixos-hardware.nixosModules.common-cpu-intel
          # nixos-hardware.nixosModules.common-gpu-intel
          # nixos-hardware.nixosModules.common-pc-ssd

          # Load home manager module.
          home-manager.nixosModules.home-manager

          # Define actual home configuration for my user.
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              # If home manager overrides an existing config, keep the file with this extension.
              backupFileExtension = "backup";

              extraSpecialArgs = {inherit inputs;}; # expose flake inputs in home manager

              users.johannes = {
                imports = [
                  ./users/johannes/framework.nix
                  nix-index-database.homeModules.default
                  nixvim.homeModules.nixvim
                ];
              };
            };
          }
        ];
      };
    };
  };
}
