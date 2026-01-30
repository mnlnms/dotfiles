{
  description = "NixOS systems and tools by mitchellh";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Master nixpkgs is used for really bleeding edge packages. Warning
    # that this is extremely unstable and shouldn't be relied on. Its
    # mostly for testing.
    nixpkgs-master.url = "github:nixos/nixpkgs";

    # Build a custom WSL installer
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      # We need to use nightly home-manager because it contains this
      # fix we need for nushell nightly:
      # https://github.com/nix-community/home-manager/commit/a69ebd97025969679de9f930958accbe39b4c705
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      # url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, nix-homebrew, homebrew-core, homebrew-cask, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
    darwinConfigurations.macbook-air-m1 = mkSystem "macbook-air-m1" {
      system = "aarch64-darwin";
      user   = "mnl";
      darwin = true;
    };
  };
}
