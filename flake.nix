{
  description = "Neovim config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default = { config, pkgs, ... }: {
      programs.neovim.enable = true;

      home.file.".config/nvim" = {
        source = builtins.filterSource
          (path: type:
            !(builtins.elem (baseNameOf path) [ "flake.nix" "flake.lock" "readme.md" ]))
          self;
        recursive = true;
      };
    };
  };
}

