{
  description = "Your new nix config";


  # inputs
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-colors.url = "github:misterio77/nix-colors";
    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    matugen.url = "github:InioX/matugen";
    hyprland.url = "github:hyprwm/Hyprland";
  };



  #outputs = {self, nixpkgs, home-manager, ... } @inputs: let
  outputs = inputs@{ self, home-manager, nixpkgs, ... }: 
  {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage ./ags {inherit inputs;};      
  
    # nix configuration                                                       #in {
    nixosConfigurations = {

      # setting asztal
      BlackHole = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
        modules = [./nixos/configuration.nix];
      };
    };

      # setting my main config file
      #BlackHole = nixpkgs.lib.nixosSystem {
      #  specialArgs = {inherit inputs;};
        # > Our main nixos configuration file <
      #  modules = [./nixos/configuration.nix];
      #  };
      #};

    homeConfigurations = {
      "thzero@BlackHole" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { 
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
       # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}


