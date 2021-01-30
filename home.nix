{ config, pkgs, ... }:

let
  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy 
    git-crypt     
    hub          
    tig           
  ];

  haskellPkgs = with pkgs.haskellPackages; [
    # brittany            
    cabal2nix               
    cabal-install           
    implicit-hie
    ghc                    
    stack
  ] ++ (with pkgs.haskell.packages.ghc865; [ haskell-language-server ]);

  fishConf = builtins.readFile ./programs/fish/config.fish;

  tmuxConf = builtins.readFile ./programs/tmux/.tmux.conf;
in
{
  home.packages = with pkgs; [
    aprutil
    awscli
    fd
    go
    htop
    hugo
    jo
    jq
    ripgrep
    rnix-lsp
    tree
 ] ++ gitPkgs ++ haskellPkgs;

  imports = [
    ./programs/neovim/default.nix
    ./programs/git/default.nix
  ]; 

  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox";
    };
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.magit
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = fishConf;
  };

  programs.fzf = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    prefix = "M-b";
    sensibleOnTop = false;
    shell = "$HOME/.nix-profile/bin/fish";
    historyLimit=5000;
    clock24 = true;
    extraConfig = tmuxConf;
    plugins = with pkgs; [
      {
         plugin = tmuxPlugins.resurrect;
         extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };
}


