{ config, pkgs, ... }: {
  # Set in Sept 2024 as part of the macOS Sequoia release.
  system.stateVersion = 6;

  # We use proprietary software on this machine
  nixpkgs.config.allowUnfree = true;

  # Keep in async with vm-shared.nix. (todo: pull this out into a file)
  nix = {
    # We use the determinate-nix installer which manages Nix for us,
    # so we don't want nix-darwin to do it.
    enable = false;

    # We need to enable flakes
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  environment.systemPackages = with pkgs; [
    cachix
  ];
}
