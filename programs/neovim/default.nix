{ config, lib, pkgs, ... }:

let 
  extraConfig = builtins.readFile ./config.vim;

  custom-plugins = pkgs.callPackage ./custom-plugins.nix {
    inherit (pkgs.vimUtils) buildVimPlugin;
  };

  cocConfig   = builtins.readFile ./coc.vim;

  cocSettings = builtins.toJSON (import ./coc-settings.nix);

  plugins = pkgs.vimPlugins // custom-plugins;

in { 
  programs.neovim = {

    enable = true;

    plugins      = with plugins; [
      #coc
      coc-nvim
      coc-yank
      coc-json
      coc-yank
      coc-pairs
      coc-json
#      coc-actions
#      coc-css
#      coc-html
#      coc-tsserver
#      coc-yaml
#      coc-lists
#      coc-snippets
#      coc-python
#      coc-clangd
#      coc-prettier
#      coc-xml
#      coc-syntax
      coc-git
#      coc-marketplace
#      coc-highlight
      fzf-vim
      haskell-vim
      indentLine
      neoterm
      nerdtree
      nerdtree-git-plugin
      purescript-vim
      tender-vim
      vim-airline
      vim-airline-themes
      vim-apprentice
      vim-devicons
      vim-fish
      vim-floaterm
      vim-go
      vim-gruvbox
      vim-markdown-preview
      vim-nix 
#      vim-ripgrep
      vim-scala
      vim-tmux
    ];


    extraConfig = extraConfig + cocConfig;

    withNodeJs   = true;
    withPython = true;
    withPython3  = true;

    viAlias      = true;
    vimAlias     = true;
  };

  xdg.configFile = {
    "nvim/coc-settings.json".text = cocSettings;
  };
}
