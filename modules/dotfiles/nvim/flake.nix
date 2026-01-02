{
  description = "Flake for neovim configuration development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [];
          config.allowUnfree = false;
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            lua-language-server
            stylua
            selene
          ];
        };
      }
    );
}
