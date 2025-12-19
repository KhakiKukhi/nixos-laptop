{ config, pkgs, ... }:

{
	home.username = "khakikukhi";
	home.homeDirectory = "/home/khakikukhi";

	home.stateVersion = "24.05";
	
	home.sessionPath = [
  		"$HOME/.local/bin"
	];

	home.packages = [
		pkgs.blesh
		pkgs.opera
		pkgs.virt-manager
		pkgs.keychain
	];

	home.file.".local/bin/nixpush".source = ./scripts/nixpush.sh;
	home.file.".local/bin/nixstatus".source = ./scripts/nixstatus.sh;
	home.file.".local/bin/nixrebuild".source = ./scripts/nixrebuild.sh;
	home.file.".local/bin/nixrevert".source = ./scripts/nixrevert.sh;
	home.file.".local/bin/nixhistory".source = ./scripts/nixhistory.sh;
	home.file.".local/bin/nixupdate".source = ./scripts/nixupdate.sh;

	# shorthands
	# not important
	home.file.".local/bin/npu".source = config.home.file.".local/bin/nixpush".source;
	home.file.".local/bin/nst".source = config.home.file.".local/bin/nixstatus".source;
	home.file.".local/bin/nrb".source = config.home.file.".local/bin/nixrebuild".source;
	home.file.".local/bin/nrv".source = config.home.file.".local/bin/nixrevert".source;
	home.file.".local/bin/nhi".source = config.home.file.".local/bin/nixhistory".source;
	home.file.".local/bin/nup".source = config.home.file.".local/bin/nixupdate".source;

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
   		};
   
    		bashrcExtra = ''
      			# fancy bash
			source ${pkgs.blesh}/share/blesh/ble.sh

			# SSH agent via keychain
			eval "$(keychain --eval --quiet id_ed25519)"
			
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
    		#addKeysToAgent = "yes";
  	};


#====================================================================

  	#services.ssh-agent.enable = true;

}
