{
  description = "Neovim config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

 outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      homeManagerModules.default = { config, pkgs, ... }: {
        programs.neovim = {
          enable = true;
          package = pkgs.neovim;
          # ✅ This is the correct, supported option
          extraConfig = ''
            lua << EOF
            vim.cmd("source ${self}/init.lua")
            EOF
          '';
        };
      };

      # optional export
      packages.${system}.nvim-config-src = pkgs.runCommand "nvim-config-src" {} ''
        mkdir -p $out
        cp -r ${self}/* $out
      '';
    };
}

