# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{inputs, lib, config, pkgs, ...}:

{

  imports = [
    ./hardware-configuration.nix
    ./bootConfs.nix
  ];

  nixpkgs = {
    overlays = [];
    

    config = {
      allowUnfree = true;
    };
  };


  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);


  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = ["nix-command" "flakes"];
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };


  
  programs.hyprland.enable = true;
  programs.fish.enable = true;
  xdg.portal.wlr.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  console.keyMap = "br-abnt2";
  hardware.opengl.enable = true;
  services.xserver = {
	xkb.layout = "br-abnt2";
	libinput.enable = true;
	videoDrivers = ["nvidia"];
  };

  

  environment.systemPackages = with pkgs; [
    vim
	  wget
	  git
  ];



  
  networking.hostName = "BlackHole";
  networking.networkmanager.enable = true;

  services.logind.lidSwitch = "ignore";



  users.users = {
    thzero = {
      initialPassword = "1234";
      isNormalUser = true;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [];
      extraGroups = ["wheel" "networkmanager"];
     packages = with pkgs; [home-manager];
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
 
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
