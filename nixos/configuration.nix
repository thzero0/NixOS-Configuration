# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{inputs, lib, config, pkgs, ...}:

{

  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    ./hardware-configuration.nix
];



nixpkgs = {
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
];
    

config = {
      allowUnfree = true;
    };
};

  boot.loader.systemd-boot.enable = false;
  boot.loader = {
	efi = {
		canTouchEfiVariables = true;
		efiSysMountPoint = "/boot";
	};
	grub = {
		efiInstallAsRemovable = false;
		device = "nodev";
		efiSupport = true;
		default = "saved";
		enable = true;
		useOSProber = true;
		configurationLimit = 5;
		extraEntries =
		''
			menuentry "Arch Linux" {
				#set root=/dev/nvme0n1p7
				insmod part_gpt
				insmod ext2
				search --no-floppy --fs-uuid --set root= 3b8e6f07-4221-48cf-b7ca-8600c5bf5cf4
				linux /boot/vmlinuz-linux root=UUID=3b8e6f07-4221-48cf-b7ca-8600c5bf5cf4 rw nowatchdog nvme_load=YES resume=UUID=62087949-04fa-49a9-aef2-fc46c2ab884a loglevel=3
				initrd /boot/intel-ucode.img /boot/initramfs-linux.img
		}
		'';
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
	layout = "br-abnt2";
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
