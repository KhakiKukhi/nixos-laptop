{ config, pkgs, ... }:

{
  home.username = "khakikukhi";
  home.homeDirectory = "/home/khakikukhi";

  home.stateVersion = "24.05";

  programs.bash.enable = true;
}

