# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{inputs, lib, config, pkgs, ...}:

{

  imports = [
    ./hardware-configuration.nix
    ./bootConfs.nix
    ./hyprland.nix
    ./lightdm.nix
  ];




  # nix
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = ["nix-command flakes"];
      auto-optimise-store = true;
    };
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome
    nixPath = ["/etc/nix/path"];
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs); 
    
  };

  
  # environment 
  environment.etc = lib.mapAttrs' (name: value: {name = "nix/path/${name}"; value.source = value.flake;}) config.nix.registry;


  # Fish
  programs.fish.enable = true;
  
  # xdg
  xdg.portal.wlr.enable = true;
 
  # audio
  sound.enable = true;
  hardware.pulseaudio.enable = true;
 
  # keymap
  console.keyMap = "br-abnt2";
  
  # opengl
  hardware.opengl.enable = true;

 

  # packages
  environment.systemPackages = with pkgs; [
    vim
	  wget
	  git
  ];



  # Network  
  networking.hostName = "BlackHole";
  networking.networkmanager.enable = true;


  # LoginID
  services.logind.lidSwitch = "ignore";


  # users
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


  # services
  services = {
    xserver = {   
	    xkb.layout = "br-abnt2";
	    libinput.enable = true;
    };
    openssh = {  
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };


  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
