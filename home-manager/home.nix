# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    ./ags.nix
  ];

  nixpkgs = {
    overlays = [
    ];
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
	ags
	(nerdfonts.override {fonts = 
	[
	"RobotoMono"
	"FiraCode"
	];})
 ];
  
  programs.fish = {
  	enable = true;
  	interactiveShellInit = ''
		fish_add_path --append ~/.local/bin
		'';

	functions = {
		ranger = ''
			set tempfile (mktemp -t tmp.XXXXXX)
        		command ranger --choosedir=$tempfile $argv
        		set return_value $status

       	 		if test -s $tempfile
                		set ranger_pwd (cat $tempfile)
                		if test -n $ranger_pwd -a -d $ranger_pwd
                        		builtin cd -- $ranger_pwd
                		end
        		end

        		command rm -f -- $tempfile
        		return $return_value
		'';
		fish_greeting = "echo ❄️  Welcome, its (set_color cyan; date +%T)";
		switchConf = "cd /home/thzero/nixos-config & sudo nixos-rebuild switch --flake .#BlackHole";
		switchHome = "cd /home/thzero/nixos-config & home-manager switch --flake .#thzero@BlackHole";
	};
  };
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.05";
}
