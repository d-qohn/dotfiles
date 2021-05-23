{ config, pkgs, ... }:

let
  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy 
    git-crypt     
    hub          
    tig           
  ];

#  emacs = import ./programs/emacs/default.nix {
#    pkgs = pkgs;
#  };

  haskell-language-server = pkgs.haskellPackages.haskell-language-server.override { 
    supportedGhcVersions = [ "884" "901" ]; 
  };
 
  haskellPkgs = with pkgs.haskellPackages; [
    # brittany            
    cabal2nix                          
    implicit-hie
    ghc                    
    stack
    
 ] ++ (with pkgs.haskell.packages.ghc8104; [ 
    # cabal-install
#    haskell-language-server 
  ]);
# ] ++ (with pkgs.haskell.packages.ghc865; [ 
#    cabal-install
#    haskell-language-server 
#  ]);

  fishConf = builtins.readFile ./programs/fish/config.fish;

  tmuxConf = builtins.readFile ./programs/tmux/.tmux.conf;
in
{
  home.packages = with pkgs; [
    aprutil
    awscli
    dhall
    fd
    go
    htop
    hugo
    jo
    jq
    ripgrep
    rnix-lsp
    tree
    vagrant
 ] ++ gitPkgs ++ haskellPkgs;

  imports = [
    ./programs/git/default.nix
    ./programs/neovim/default.nix
    ./programs/tmux/default.nix
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
      epkgs.all-the-icons
      epkgs.company
      epkgs.counsel
      epkgs.doom-themes
      epkgs.doom-modeline
      epkgs.evil
      epkgs.find-file-in-project
      epkgs.general
      epkgs.ivy
      epkgs.smartparens
      epkgs.typescript-mode
      epkgs.lsp-mode
      epkgs.lsp-ui
      epkgs.lsp-java
      epkgs.lsp-metals
      epkgs.lsp-haskell
      epkgs.lsp-treemacs
      epkgs.lsp-ivy
      epkgs.helm-lsp
      epkgs.which-key
      epkgs.magit
      epkgs.nix-mode
      epkgs.smartparens
      epkgs.swiper
    ];
  };

  programs.fish = {
    enable = true;
    shellInit = fishConf;
  };

  programs.fzf = {
    enable = true;
  };

  programs.home-manager = {
    enable = true;
    path = "…";
  };

  # home.file.".emacs.d".source = ./programs/emacs/.emacs.d;
  home.file.".emacs.d/init.el".source = ./programs/emacs/init.el;
}


