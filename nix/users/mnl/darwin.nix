{ inputs, config, pkgs, ... }:

{

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "mnl";
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;
    casks  = [
      "spotify"
      "zen"
      "helium-browser"
      "bitwarden"
      "ghostty"
      "vesktop"
      "winbox"
      "zerotier-one"
    ];

    brews = [
    ];
    
    onActivation = {
      cleanup = "uninstall";
      autoUpdate = true;
    };
  };
  
  # Fonts
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    nerd-fonts.jetbrains-mono
  ];

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.mnl = {
    home = "/Users/mnl";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Required for some settings like homebrew to know what user to apply to.
  system.primaryUser = "mnl";
  system.startup.chime = false;
  system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = true;
  system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = true;
  system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
  system.defaults.trackpad.Clicking = true;
  system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  system.defaults.dock.autohide = true;
  system.defaults.controlcenter.BatteryShowPercentage = true;
  system.defaults.hitoolbox.AppleFnUsageType = "Do Nothing";
  system.defaults.loginwindow.DisableConsoleAccess = true;
  system.defaults.loginwindow.GuestEnabled = false;
  # Finder
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllFiles = true;
  system.defaults.finder.FXPreferredViewStyle = "Nlsv";
  system.defaults.finder.ShowPathbar = true;
  system.defaults.finder.ShowStatusBar = true;
  system.defaults.finder._FXShowPosixPathInTitle = true;
  system.defaults.finder._FXSortFoldersFirst = true;
  # Window Management
  system.defaults.NSGlobalDomain.AppleSpacesSwitchOnActivate = true;
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
  system.defaults.dock.scroll-to-open = true;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 48;
  system.defaults.WindowManager.EnableStandardClickToShowDesktop = false;

}
