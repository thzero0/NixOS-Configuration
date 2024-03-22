{inputs, config, lib, pkgs, ...}: {

  services.xserver.enable = true;
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeter.enable = true;

  };

/*
  services.xserver.displayManager.job.execCmd = ''
      export PATH=${lightdm}/sbin:$PATH
      exec ${lightdm}/sbin/lightdm
  '';
*/

}
