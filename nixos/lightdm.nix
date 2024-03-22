{inputs, config, lib, pkgs, ...}: {
 
  services = {
    xserver = {
      displayManager.lightdm = {
        enable = true;
        greeters.slick.enable = true;
      };
    };
  };
  # Fix shutdown taking a long time
  # https://gist.github.com/worldofpeace/27fcdcb111ddf58ba1227bf63501a5fe
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    DefaultTimeoutStartSec=10s
  '';

}
