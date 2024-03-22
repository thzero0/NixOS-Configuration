{
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
		  cfgRebuild= "cd /home/thzero/nixos-config & sudo nixos-rebuild switch --flake .#BlackHole";
		  homeRebuild = "cd /home/thzero/nixos-config & home-manager switch --flake .#thzero@BlackHole";
	  };
  };  
}
