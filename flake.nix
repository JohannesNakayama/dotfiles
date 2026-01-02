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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nix-index-database,
    ...
  } @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs.flake-inputs = inputs; # make current inputs available as "flake-inputs" in configuration.nix
        modules = [
          # Load system configuration.
          ./configuration.nix
          ./hardware-configuration.nix

          # Apply hardware optimizations.
          # nixos-hardware.nixosModules.common-cpu-amd
          # nixos-hardware.nixosModules.common-gpu-amd
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

              users.johannes = {
                imports = [
                  ./home.nix
                  nix-index-database.homeModules.default
                ];
              };
            };
          }
        ];
      };
    };
  };
}
