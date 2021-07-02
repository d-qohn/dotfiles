{ config, pkgs, ... }:

let
  gitPkgs = with pkgs.gitAndTools; [
    diff-so-fancy 
    git-crypt     
    hub          
    tig           
  ];

  haskell-language-server = pkgs.haskellPackages.haskell-language-server.override { 
    supportedGhcVersions = [ "884" "901" ]; 
  };
 
  haskellPkgs = with pkgs.haskellPackages; [
    # brittany            
    cabal2nix                          
    implicit-hie
    stack
    
 ] ++ (with pkgs.haskell.packages.ghc8104; [ 
  ]);

  fishConf = builtins.readFile ./programs/fish/config.fish;

  tmuxConf = builtins.readFile ./programs/tmux/.tmux.conf;

  # ghc = pkgs.haskell.compiler.ghc865;
in
{
  home.packages = with pkgs; [
    adoptopenjdk-hotspot-bin-8
    aprutil
    awscli
    cabal-install
    cachix
    dhall
    fd
    # ghc
    go
    gradle
    grpcui
    grpcurl
    htop
    hugo
    jhead
    jo
    jq
    maven
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
      epkgs.consult
      epkgs.counsel
      epkgs.doom-themes
      epkgs.doom-modeline
      epkgs.evil
      epkgs.exwm
      epkgs.find-file-in-project
      epkgs.fira-code-mode
      epkgs.general
      epkgs.highlight-indent-guides
      epkgs.ivy
      epkgs.marginalia
      epkgs.material-theme
      epkgs.smartparens
      epkgs.treemacs
      epkgs.treemacs-all-the-icons
      epkgs.treemacs-evil
      epkgs.treemacs-icons-dired
      epkgs.treemacs-magit
      epkgs.treemacs-persp
      epkgs.treemacs-projectile
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
      epkgs.neotree
      epkgs.nix-mode
      epkgs.protobuf-mode
      epkgs.plantuml-mode
      epkgs.selectrum
      epkgs.smartparens
      epkgs.swiper
      # epkgs.vertico
      epkgs.vterm
      epkgs.yaml
      epkgs.yaml-mode
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

  home.file.".emacs.d/init.el".source = ./programs/emacs/init.el;
}


