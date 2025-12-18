{ config, pkgs, ... }:

{
	home.username = "khakikukhi";
	home.homeDirectory = "/home/khakikukhi";

	home.stateVersion = "24.05";

	home.packages = [
		pkgs.blesh
	];

	home.file.".local/bin/nixpush".source = ./scripts/nixpush.sh;
	home.file.".local/bin/nixstatus".source = ./scripts/nixstatus.sh;

#====================================================================

	programs.bash = {
		enable = true;
		enableCompletion = true;
    
		shellAliases = {
			ll = "ls -lah";
      			gs = "git status";
      			ga = "git add";
      			gc = "git commit";
      			gp = "git push";
    			nixrebuild = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
   		};
   
    		bashrcExtra = ''
      			# fancy bash
			source ${pkgs.blesh}/share/blesh/ble.sh
			
			export EDITOR=vim
      			export HISTCONTROL=ignoredups:erasedups
      			export HISTSIZE=10000
      			export HISTFILESIZE=20000
      
      			# nicer prompt (simple, readable)
      			PS1="[\u@\h \W]\\$ "
    		'';
  	};

  	programs.ssh = {
    		enable = true;
    		addKeysToAgent = "yes";
  	};


#====================================================================

  	services.ssh-agent.enable = true;

}
