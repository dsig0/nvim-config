{
  description = "Neovim config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      # ✅ Home Manager module (works fine despite the warning)
      homeManagerModules.default = { config, pkgs, ... }: {
        programs.neovim = {
          enable = true;
          package = pkgs.neovim;
          extraLuaConfig = ''
            vim.cmd("source ${self}/init.lua")
          '';
        };
      };

      # ✅ Proper derivation for your config source
      packages.${system}.nvim-config-src = pkgs.runCommand "nvim-config-src" {} ''
        mkdir -p $out
        cp -r ${self}/* $out
      '';
    };
}

