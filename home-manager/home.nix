# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{inputs, lib, config, pkgs, ... }: {
  
  imports = [
    ./ags.nix
    ./hyprland.nix
    ./nvim.nix
    ./fish.nix
  ];


  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "thzero";
    homeDirectory = "/home/thzero";
  };

  programs.neovim.enable = true;
  home.packages = with pkgs; [
	firefox
	tree
	alacritty
	ranger
	kitty
	neofetch
	(nerdfonts.override {fonts = 
	[
	"RobotoMono"
	"FiraCode"
	];})
  icon-library
  libnotify
  morewaita-icon-theme
  gnome.adwaita-icon-theme
  papirus-icon-theme
  qogir-icon-theme
  pulseaudio
  adw-gtk3
  zip
  unzip
 ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
