{
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiInstallAsRemovable = false;
      device = "nodev";
      efiSupport = true;
      enable = true;
      useOSProber = true;
      configurationLimit = 5;
    };
  };
}
