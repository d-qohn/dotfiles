{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager  = "diff-so-fancy | less --tabs=4 -RFX";
    };
  };

in {
  programs.git = {

    aliases = {
      br = "branch";
      ll = "log --decorate --numstat";
      ls = "log --decorate";
      ca = "commit -am";
      cm = "commit -m";
      co = "checkout";
      dc = "diff --cached";
      st = "status";
    };

    enable = true;
    extraConfig = gitConfig;

    userEmail = "d.qohn29@gmail.com";
    userName = "DQOHN";
  };

}
